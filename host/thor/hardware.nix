{ inputs
, ...
}: {
  imports = [
    inputs.disko.nixosModules.disko
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-hidpi
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd

    (import ./disks.nix { })

    ../common/services/fwupd.nix
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  hardware = {
    enableAllFirmware = true;
  };

  swapDevices = [{
    device = "/.swap/swapfile";
    size = 2048;
  }];
}

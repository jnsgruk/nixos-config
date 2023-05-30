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
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  hardware = {
    enableAllFirmware = true;
  };

  swapDevices = [{
    device = "/.swap/swapfile";
    size = 2048;
  }];

  # Setup additional 1TB data drive with LUKS encryption
  # fileSystems."/data" = {
  #   device = "/dev/mapper/data";
  #   fsType = "ext4";
  # };

  environment.etc = {
    "crypttab".text = ''
      data  /dev/disk/by-partlabel/data  /etc/data.keyfile
    '';
  };
}

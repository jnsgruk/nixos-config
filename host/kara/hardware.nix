{ inputs, ... }:

{
  imports = [
    inputs.disko.nixosModules.disko
    (import ./disks.nix { })

    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.nixos-hardware.nixosModules.common-hidpi
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd

    ../common/hardware/audioengine.nix
    ../common/hardware/bluetooth.nix

    ../common/services/fwupd.nix

    ../common/services/flypi.nix
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  hardware = {
    enableAllFirmware = true;
    amdgpu.loadInInitrd = true;
  };

  swapDevices = [{
    device = "/.swap/swapfile";
    size = 2048;
  }];
}

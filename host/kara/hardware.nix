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
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  swapDevices = [{
    device = "/.swap/swapfile";
    size = 2048;
  }];
}

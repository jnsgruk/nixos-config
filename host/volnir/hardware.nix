{ lib, inputs, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.raspberry-pi-4
    (import ./disks.nix { inherit lib; })
  ];

  hardware.raspberry-pi."4".fkms-3d.enable = true;

  nixpkgs.hostPlatform = "aarch64-linux";
}

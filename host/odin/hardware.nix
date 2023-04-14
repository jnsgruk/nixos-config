{ lib
, inputs
, pkgs
, ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.dell-xps-9370
    inputs.nixos-hardware.nixosModules.common-hidpi
    ../common/hardware/bluetooth.nix
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  hardware = {
    enableAllFirmware = true;
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/5ca1f3fa-c43b-4f10-96c2-e35643a9617d";
    fsType = "btrfs";
    options = [ "subvol=@" ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/5ca1f3fa-c43b-4f10-96c2-e35643a9617d";
    fsType = "btrfs";
    options = [ "subvol=@home" ];
  };

  fileSystems."/var" = {
    device = "/dev/disk/by-uuid/5ca1f3fa-c43b-4f10-96c2-e35643a9617d";
    fsType = "btrfs";
    options = [ "subvol=@var" ];
  };

  fileSystems."/.snapshots" = {
    device = "/dev/disk/by-uuid/5ca1f3fa-c43b-4f10-96c2-e35643a9617d";
    fsType = "btrfs";
    options = [ "subvol=@snapshots" ];
  };

  fileSystems."/.swap" = {
    device = "/dev/disk/by-uuid/5ca1f3fa-c43b-4f10-96c2-e35643a9617d";
    fsType = "btrfs";
    options = [ "subvol=@swap" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/47DA-705F";
    fsType = "vfat";
  };

  swapDevices = [{
    device = "/.swap/swapfile";
    size = 2048;
  }];
}

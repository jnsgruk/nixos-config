{ inputs
, pkgs
, ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-hidpi
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  hardware = {
    enableAllFirmware = true;
  };

  # TODO: Replace with Disko config
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/67e2aec0-abb8-4d0d-b8d4-556a8b2f3532";
    fsType = "btrfs";
    options = [ "subvol=@" "compress=lzo" "noatime" "nodiratime" "ssd" ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/67e2aec0-abb8-4d0d-b8d4-556a8b2f3532";
    fsType = "btrfs";
    options = [ "subvol=@home" "compress=lzo" "noatime" "nodiratime" "ssd" ];
  };

  fileSystems."/var" = {
    device = "/dev/disk/by-uuid/67e2aec0-abb8-4d0d-b8d4-556a8b2f3532";
    fsType = "btrfs";
    options = [ "subvol=@var" "compress=lzo" "noatime" "nodiratime" "ssd" ];
  };

  fileSystems."/.snapshots" = {
    device = "/dev/disk/by-uuid/67e2aec0-abb8-4d0d-b8d4-556a8b2f3532";
    fsType = "btrfs";
    options = [ "subvol=@snapshots" "compress=lzo" "noatime" "nodiratime" "ssd" ];
  };

  fileSystems."/.swap" = {
    device = "/dev/disk/by-uuid/67e2aec0-abb8-4d0d-b8d4-556a8b2f3532";
    fsType = "btrfs";
    options = [ "subvol=@swap" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/FD29-48A2";
    fsType = "vfat";
  };

  swapDevices = [{
    device = "/.swap/swapfile";
    size = 2048;
  }];
}

{ inputs
, ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-z13
    ../common/hardware/bluetooth.nix
  ];

  services.fwupd.enable = true;

  nixpkgs.hostPlatform = "x86_64-linux";

  # TODO: Replace with Disko config
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/99db9e90-c813-4469-a6a7-bae6b8f49955";
      fsType = "btrfs";
      options = [ "subvol=@" ];
    };

    "/home" = {
      device = "/dev/disk/by-uuid/99db9e90-c813-4469-a6a7-bae6b8f49955";
      fsType = "btrfs";
      options = [ "subvol=@home" ];
    };

    "/var" = {
      device = "/dev/disk/by-uuid/99db9e90-c813-4469-a6a7-bae6b8f49955";
      fsType = "btrfs";
      options = [ "subvol=@var" ];
    };

    "/.snapshots" = {
      device = "/dev/disk/by-uuid/99db9e90-c813-4469-a6a7-bae6b8f49955";
      fsType = "btrfs";
      options = [ "subvol=@snapshots" ];
    };

    "/.swap" = {
      device = "/dev/disk/by-uuid/99db9e90-c813-4469-a6a7-bae6b8f49955";
      fsType = "btrfs";
      options = [ "subvol=@swap" ];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/21B1-1362";
      fsType = "vfat";
    };
  };

  swapDevices = [{
    device = "/.swap/swapfile";
    size = 2048;
  }];

}

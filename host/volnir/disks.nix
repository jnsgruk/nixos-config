{ lib, ... }:
{
  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXOS_SD";
    fsType = "ext4";
  };

  swapDevices = [
    {
      device = "/.swapfile";
      size = 2048;
    }
  ];

  zramSwap.enable = lib.mkForce false;
}

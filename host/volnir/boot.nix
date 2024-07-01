{ lib, ... }:
{
  boot = {
    initrd = {
      availableKernelModules = [ ];
      kernelModules = [ ];
    };

    loader = {
      generic-extlinux-compatible.enable = true;
      grub.enable = false;
      systemd-boot.enable = lib.mkForce false;
    };

    extraModulePackages = [ ];
    kernelModules = [ ];
  };
}

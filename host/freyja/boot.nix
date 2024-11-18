{ pkgs, lib, ... }:
{
  boot = {
    # Secure boot configuration
    bootspec.enable = true;
    loader.systemd-boot.enable = lib.mkForce false;
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };

    initrd = {
      availableKernelModules = [
        "nvme"
        "rtsx_pci_sdmmc"
        "sd_mod"
        "thunderbolt"
        "usb_storage"
        "xhci_pci"
      ];

      kernelModules = [ "dm-snapshot" ];

      luks.devices.crypt = {
        device = "/dev/nvme0n1p2";
        allowDiscards = true;
        preLVM = true;
      };
    };

    kernelModules = [
      "kvm_amd"
      "vhost_vsock"
    ];

    # Use the latest Linux kernel, rather than the default LTS
    # kernelPackages = pkgs.linuxPackages_latest;
  };
}

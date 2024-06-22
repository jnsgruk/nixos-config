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
        "ahci"
        "nvme"
        "sd_mod"
        "usb_storage"
        "usbhid"
        "xhci_pci"
      ];
    };

    kernelModules = [
      "kvm_amd"
      "vhost_vsock"
    ];

    # Use the latest Linux kernel, rather than the default LTS
    kernelPackages = pkgs.linuxPackages_latest;
  };
}

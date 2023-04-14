{ pkgs, ... }: {
  boot = {
    initrd = {
      availableKernelModules = [
        "nvme"
        "rtsx_pci_sdmmc"
        "sd_mod"
        "usb_storage"
        "xhci_pci"
      ];

      kernelModules = [ "dm-snapshot" ];

      luks.devices.crypt = {
        device = "/dev/nvme0n1p2";
        allowDiscards = true;
        preLVM = true;
      };

      systemd.enable = true;
    };

    kernelModules = [
      "kvm_intel"
      "vhost_vsock"
    ];

    kernel.sysctl = {
      "net.ipv4.ip_forward" = 1;
      "net.ipv6.conf.all.forwarding" = 1;
    };

    # Use the latest Linux kernel, rather than the default LTS
    kernelPackages = pkgs.linuxPackages_latest;

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
}

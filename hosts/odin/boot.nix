{
  pkgs,
  config,
  ...
}: {
  boot = {
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "nvme"
        "usb_storage"
        "sd_mod"
        "rtsx_pci_sdmmc"
      ];

      kernelModules = ["dm-snapshot"];

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

    kernelParams = [
      # Make sure that the XPS13 actually uses S3 sleep
      "mem_sleep_default=deep"
    ];

    blacklistedKernelModules = [
      # XPS 9370 touchpad goes over i2c
      "psmouse"
    ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
}

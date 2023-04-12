{ pkgs, ... }: {
  boot = {
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "nvme"
        "usb_storage"
        "thunderbolt"
        "sd_mod"
        "rtsx_pci_sdmmc"
      ];

      kernelModules = [
        "amdgpu"
        "dm-snapshot"
      ];

      luks.devices.crypt = {
        device = "/dev/nvme0n1p2";
        allowDiscards = true;
        preLVM = true;
      };

      systemd.enable = true;
    };

    kernelModules = [
      "kvm_amd"
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

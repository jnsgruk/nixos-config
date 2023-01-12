{ pkgs, lib, ... }: {
  imports = [
    ./hardware.nix
    ./optional/desktop.nix
    ../common/global
    ../common/users/jon
  ];

  boot = {
    kernel.sysctl = {
      "net.ipv4.ip_forward" = 1;
      "net.ipv6.conf.all.forwarding" = 1;
    };
    # Force S3 sleep mode. See README.wiki for details.
    kernelParams = [ "mem_sleep_default=deep" ];
    # XPS 9370 touchpad goes over i2c
    blacklistedKernelModules = [ "psmouse" ];
  };

  networking = {
    hostName = "odin";
    # head -c4 /dev/urandom | od -A none -t x4
    hostId = "17d07435";
    useDHCP = lib.mkDefault true;
  };

  # Power, throttling, etc.
  services.upower.enable = true;
  services.throttled.enable = lib.mkDefault true;
  services.thermald.enable = true;

  virtualisation = {
    containerd.enable = true;
    docker = {
      enable = true;
      storageDriver = "btrfs";
    };
  };
  environment.systemPackages = [ pkgs.ctop ];

  system.stateVersion = "22.11";
}

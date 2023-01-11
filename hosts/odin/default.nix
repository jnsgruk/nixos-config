{ pkgs, lib, ... }: {
  imports = [ 
    ./hardware.nix
    ./optional/desktop.nix
    ../common/global
    ../common/users/jon
  ];

  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };

  networking = {
    hostName = "odin";
    # head -c4 /dev/urandom | od -A none -t x4
    hostId = "17d07435";
    useDHCP = lib.mkDefault true;
  };
  
  services.upower.enable = true;

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
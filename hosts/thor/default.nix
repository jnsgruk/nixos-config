{ pkgs, lib, ... }: {
  imports = [ 
    ./hardware.nix
    ../common/global
    ../common/users/jon
  ];

  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };

  networking = {
    hostName = "thor";
    # head -c4 /dev/urandom | od -A none -t x4
    hostId = "96f2b9b5";
    useDHCP = lib.mkDefault true;
  };

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
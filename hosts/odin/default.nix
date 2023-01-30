{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./boot.nix
    ./hardware.nix
    ../common/global
    ../common/users/jon
    ../common/optional/desktop.nix
    ../common/optional/greetd.nix
    ../common/optional/thunar.nix
    ../common/optional/yubikey.nix
    ../common/optional/embr.nix
  ];

  networking = {
    hostName = "odin";
    # head -c4 /dev/urandom | od -A none -t x4
    hostId = "17d07435";
    useDHCP = lib.mkDefault true;
    firewall = {
      enable = true;
      allowedTCPPorts = [];
      allowedUDPPorts = [];
    };
  };

  # Power, throttling, etc.
  services.upower.enable = true;
  services.tlp.enable = true;
  services.throttled.enable = lib.mkDefault true;
  services.thermald.enable = true;

  virtualisation = {
    containerd.enable = true;
    docker = {
      enable = true;
      storageDriver = "btrfs";
    };
    lxd = {
      enable = true;
      zfsSupport = true;
    };
  };

  security = {
    apparmor.enable = true;
  };

  boot.kernelModules = [
    "ip_vs"
    "ip_vs_rr"
    "ip_vs_wrr"
    "ip_vs_sh"
    "ip_tables"
    "ip6_tables"
    "netlink_diag"
    "nf_nat"
    "overlay"
    "br_netfilter"
  ];

  environment.systemPackages = with pkgs; [apparmor-kernel-patches];

  # environment.systemPackages = [];

  system.stateVersion = "22.11";
}

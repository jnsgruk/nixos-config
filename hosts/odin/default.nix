{lib, ...}: {
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

  environment.systemPackages = [];

  system.stateVersion = "22.11";
}

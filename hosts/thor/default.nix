{lib, ...}: {
  imports = [
    ./boot.nix
    ./hardware.nix
    ../common/global
    ../common/users/jon
  ];

  networking = {
    hostName = "thor";
    # head -c4 /dev/urandom | od -A none -t x4
    hostId = "96f2b9b5";
    useDHCP = lib.mkDefault true;
    firewall = {
      allowedTCPPorts = [];
      allowedUDPPorts = [];
    };
  };

  virtualisation = {
    containerd.enable = true;
    docker = {
      enable = true;
      storageDriver = "btrfs";
    };
    lxd.enable = true;
  };

  # Workaround for https://github.com/NixOS/nixpkgs/issues/180175
  systemd.services.NetworkManager-wait-online.enable = false;

  environment.systemPackages = [];

  system.stateVersion = "22.11";
}

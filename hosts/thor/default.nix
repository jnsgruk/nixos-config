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
  };

  environment.systemPackages = [];

  system.stateVersion = "22.11";
}

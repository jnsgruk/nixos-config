{ pkgs, lib, ... }: {
  imports = [
    ./boot.nix
    ./hardware.nix
    ../common/global
    ../common/users/jon
    ./optional/desktop.nix
  ];

  networking = {
    hostName = "odin";
    # head -c4 /dev/urandom | od -A none -t x4
    hostId = "17d07435";
    useDHCP = lib.mkDefault true;
  };

  # Power, throttling, etc.
  services.upower.enable = true;
  services.tlp.enable = true;
  services.throttled.enable = lib.mkDefault true;
  services.thermald.enable = true;

  # TODO: Move this to hardware configuration?
  services.fstrim.enable = lib.mkDefault true;

  virtualisation = {
    containerd.enable = true;
    docker = {
      enable = true;
      storageDriver = "btrfs";
    };
  };

  environment.systemPackages = [ ];

  system.stateVersion = "22.11";
}

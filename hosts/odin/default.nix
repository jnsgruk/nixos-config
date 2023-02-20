{ pkgs
, lib
, ...
}: {
  imports = [
    ./boot.nix
    ./hardware.nix

    ../common/global
    ../common/users/jon

    ../common/optional/virt

    ../common/optional/desktop.nix
    ../common/optional/greetd.nix
    ../common/optional/thunar.nix
    ../common/optional/yubikey.nix
  ];

  networking = {
    hostName = "odin";
    # head -c4 /dev/urandom | od -A none -t x4
    hostId = "17d07435";
    useDHCP = lib.mkDefault true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];
    };
  };

  services = {
    syncthing = {
      enable = true;
      user = "jon";
      dataDir = "/home/jon/data";
      configDir = "/home/jon/data/.syncthing";
      guiAddress = "100.124.10.79:8384";
    };
  };

  # Power, throttling, etc.
  services.upower.enable = true;
  services.tlp.enable = true;
  services.throttled.enable = lib.mkDefault true;
  services.thermald.enable = true;

  environment.systemPackages = [ ];

  system.stateVersion = "22.11";
}

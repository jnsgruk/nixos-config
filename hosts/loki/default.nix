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
    hostName = "loki";
    # head -c4 /dev/urandom | od -A none -t x4
    hostId = "4c53e052";
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
      guiAddress = "100.73.28.58:8384";
    };
  };

  environment.systemPackages = [ ];

  system.stateVersion = "22.11";
}

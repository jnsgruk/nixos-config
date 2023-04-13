{ lib
, ...
}: {
  imports = [
    ./boot.nix
    ./hardware.nix

    ../common/global
    ../common/users/jon

    ../common/optional/virt

    ../common/optional/1password.nix
    ../common/optional/desktop.nix
    ../common/optional/greetd.nix
    ../common/optional/ledger.nix
    ../common/optional/nautilus.nix
    ../common/optional/yubikey.nix
  ];

  networking = {
    hostName = "freyja";
    # head -c4 /dev/urandom | od -A none -t x4
    hostId = "c120a672";
    useDHCP = lib.mkDefault true;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22000 # syncthing
      ];
      allowedUDPPorts = [
        22000 # syncthing
        21027 # syncthing
      ];
    };
  };

  # Power, throttling, etc.
  services.upower.enable = true;
  services.tlp.enable = true;
  services.thermald.enable = true;

  environment.systemPackages = [ ];

  system.stateVersion = "22.11";
}

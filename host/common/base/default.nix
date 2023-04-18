{ hostname
, hostid
, pkgs
, lib
, ...
}: {
  imports = [
    ./locale.nix

    ../hardware/yubikey.nix

    ../services/fwupd.nix
    ../services/networkmanager.nix
    ../services/openssh.nix
    ../services/swapfile.nix
    ../services/tailscale.nix
  ];

  networking = {
    hostName = hostname;
    hostId = hostid;
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

  environment.systemPackages = with pkgs; [
    bat
    binutils
    ctop
    curl
    dive
    duf
    exa
    git
    htop
    jq
    killall
    kubectl
    pciutils
    ripgrep
    rsync
    tree
    unzip
    usbutils
    wget
    yq-go
  ];

  programs = {
    zsh.enable = true;
    _1password.enable = true;
  };

  services.chrony.enable = true;

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };
}

{ hostname
, pkgs
, lib
, ...
}: {
  imports = [
    ./locale.nix

    ../services/firewall.nix
    ../services/networkmanager.nix
    ../services/openssh.nix
    ../services/swapfile.nix
    ../services/tailscale.nix
  ];

  networking = {
    hostName = hostname;
    useDHCP = lib.mkDefault true;
  };

  environment.systemPackages = with pkgs; [
    bat
    binutils
    curl
    dig
    dua
    duf
    exa
    fd
    file
    git
    htop
    jq
    killall
    pciutils
    ripgrep
    rsync
    traceroute
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

  services = {
    chrony.enable = true;
    journald.extraConfig = "SystemMaxUse=250M";
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };
}

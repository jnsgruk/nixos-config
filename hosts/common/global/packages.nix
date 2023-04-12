{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    bat
    binutils
    ctop
    curl
    dive
    exa
    git
    htop
    killall
    pciutils
    tree
    unzip
    usbutils
    wget
  ];

  programs.zsh.enable = true;
}

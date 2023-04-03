{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    bat
    ctop
    curl
    dive
    exa
    git
    htop
    killall
    tree
    unzip
    wget
  ];

  programs.zsh.enable = true;
}

{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    bat
    curl
    exa
    git
    htop
    tree
    unzip
    wget
  ];
}
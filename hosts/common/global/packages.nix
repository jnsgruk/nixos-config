{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    bat
    ctop
    curl
    exa
    git
    htop
    killall
    tree
    unzip
    wget
  ];
}

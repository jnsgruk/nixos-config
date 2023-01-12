{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    bat
    ctop
    curl
    exa
    git
    htop
    tree
    unzip
    wget
  ];
}

{ pkgs, ... }: {
  basePackages = with pkgs; [
    _1password
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
}

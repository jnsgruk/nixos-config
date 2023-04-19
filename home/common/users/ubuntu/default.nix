{ pkgs, ... }: {
  imports = [
    ../../dev/python.nix
    ../../dev/go.nix
  ];

  home.packages = with pkgs; [
    bat
    ctop
    dive
    duf
    exa
    git
    jq
    kubectl
    ripgrep
    rsync
    terraform
    tree
    unzip
    wget
    yq-go
  ];
}

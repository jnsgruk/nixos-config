{ pkgs, ... }: {
  imports = [
    ../../dev/python.nix
    ../../dev/go.nix
    ../../dev/cloud.nix
    ../../dev/containers.nix
  ];

  home.packages = with pkgs; [
    duf
    ripgrep
    rsync
    tree
    unzip
    wget
    yq-go
  ];
}

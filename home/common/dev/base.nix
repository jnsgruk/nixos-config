{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Container tooling
    dive
    kubectl
    skopeo

    # Go tooling
    go
    go-tools
    gofumpt
    gopls

    # Nix tooling
    cachix
    deadnix
    nixpkgs-fmt
    nurl
    rnix-lsp
    statix

    # Python tooling
    ruff
    (pkgs.python3.withPackages (p: with p; [
      tox
      virtualenv
    ]))

    # Shell tooling
    shellcheck
    shfmt
  ];
}

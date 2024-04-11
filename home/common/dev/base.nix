{ pkgs, ... }:
{
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
    deadnix
    nil
    nix-init
    # My custom wrapper that does nixfmt + deadnix + statix
    nixfmt-plus
    nixfmt-rfc-style
    nurl
    statix

    # Python tooling
    ruff
    (pkgs.python3.withPackages (
      p: with p; [
        tox
        virtualenv
      ]
    ))

    # Shell tooling
    shellcheck
    shfmt
  ];
}

{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ijq

    # Rust tooling
    cargo
    rust-analyzer
    rustfmt
    rustc

    gnumake
    gcc

    nodejs
    nodePackages_latest.prettier

    spread

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
    uv
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

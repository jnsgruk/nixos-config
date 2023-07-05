# Custom packages, that can be defined similarly to ones from nixpkgs
# Build them using 'nix build .#example' or (legacy) 'nix-build -A example'

{ pkgs ? (import ../nixpkgs.nix) { } }: {
  ght = pkgs.callPackage ./ght { };
  homepage = pkgs.callPackage ./homepage { };
  lxd-ui = pkgs.callPackage ./lxd-ui.nix { };
  # Remove this once Traefik 3 is properly released and in nixpkgs
  traefik-3 = pkgs.callPackage ./traefik-3.nix { };
}

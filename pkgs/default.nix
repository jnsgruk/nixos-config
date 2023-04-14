# Custom packages, that can be defined similarly to ones from nixpkgs
# Build them using 'nix build .#example' or (legacy) 'nix-build -A example'

{ pkgs ? (import ../nixpkgs.nix) { } }: {
  sfpro-font = pkgs.callPackage ./sfpro-font.nix { };
  sf-mono-liga-font = pkgs.callPackage ./sf-mono-liga-font.nix { };
  sway-scripts = pkgs.callPackage ./sway-scripts { };
}

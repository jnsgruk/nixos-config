# Custom packages, that can be defined similarly to ones from nixpkgs
# Build them using 'nix build .#example' or (legacy) 'nix-build -A example'

{ pkgs ? (import ../nixpkgs.nix) { } }: {
  icloudpd = pkgs.callPackage ./icloudpd { };
  ght = pkgs.callPackage ./ght { };

  nixfmt = pkgs.writeShellApplication {
    name = "nixfmt";
    runtimeInputs = with pkgs; [ deadnix nixpkgs-fmt statix ];
    text = "set -x; deadnix --edit; statix fix; nixpkgs-fmt .";
  };
}

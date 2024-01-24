{ pkgs, ... }: {
  home.packages = with pkgs; [
    cachix
    deadnix
    nil
    nixpkgs-fmt
    nurl
    rnix-lsp
    statix
  ];
}

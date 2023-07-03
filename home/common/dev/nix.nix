{ pkgs, ... }: {
  home.packages = with pkgs; [
    cachix
    deadnix
    nixpkgs-fmt
    nurl
    rnix-lsp
    nil
  ];
}

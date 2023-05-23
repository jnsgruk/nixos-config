{ pkgs, ... }: {
  home.packages = with pkgs; [
    deadnix
    nixpkgs-fmt
    nurl
    rnix-lsp
  ];
}

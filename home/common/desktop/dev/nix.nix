{ pkgs, ... }: {
  home.packages = with pkgs; [
    deadnix
    nixpkgs-fmt
    rnix-lsp
  ];
}

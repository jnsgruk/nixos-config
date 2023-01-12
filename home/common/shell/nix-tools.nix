{ pkgs, ... }: {
  home.packages = with pkgs; [
    alejandra
    deadnix
    rnix-lsp
  ];
}

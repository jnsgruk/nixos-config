{pkgs, ...}: {
  home.packages = with pkgs; [
    alejandra
    deadnix
    nixpkgs-fmt
    # rnix-lsp
  ];
}

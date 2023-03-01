{ pkgs, ... }: {
  programs.go.enable = true;

  home.packages = with pkgs; [
    delve
    go-tools
    gopls
  ];
}

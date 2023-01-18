{pkgs, ...}: {
  home.packages = with pkgs; [
    charmcraft
  ];
}

{ pkgs, ... }:
{
  home.packages = with pkgs; [
    grimblast
  ];
}

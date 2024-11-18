{ pkgs, ... }:
{
  programs.nh = {
    enable = true;
    package = pkgs.nh;
    flake = "/home/jon/nixos-config";
    clean = {
      enable = true;
      extraArgs = "--keep-since 10d --keep 3";
    };
  };
}

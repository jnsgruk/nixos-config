{ inputs, pkgs, ... }:
{
  imports = [ "${inputs.unstable}/nixos/modules/programs/nh.nix" ];

  programs.nh = {
    enable = true;
    package = pkgs.unstable.nh;
    flake = "/home/jon/nixos-config";
    clean = {
      enable = true;
      extraArgs = "--keep-since 14d --keep 5";
    };
  };
}

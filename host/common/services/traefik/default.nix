{ pkgs, hostname, lib, ... }:
{
  imports = [ ]
    ++ lib.optional (builtins.pathExists (./. + "/${hostname}.nix")) ./${hostname}.nix;

  services.traefik = {
    enable = true;
    package = pkgs.traefik-3;
  };
}

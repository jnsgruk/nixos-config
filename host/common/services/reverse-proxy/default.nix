{
  pkgs,
  hostname,
  lib,
  ...
}:
{
  imports = lib.optional (builtins.pathExists (./. + "/${hostname}.nix")) ./${hostname}.nix;

  services.caddy = {
    enable = true;
    package = pkgs.custom-caddy;
  };
}

{ hostname, lib, pkgs, inputs, ... }:
{
  disabledModules = [ "services/misc/homepage-dashboard.nix" ];
  imports = [ "${inputs.unstable}/nixos/modules/services/misc/homepage-dashboard.nix" ]
    ++ lib.optional (builtins.pathExists (./. + "/${hostname}.nix")) ./${hostname}.nix;

  services.homepage-dashboard = {
    enable = true;
    package = pkgs.unstable.homepage-dashboard;
    openFirewall = true;
  };
}

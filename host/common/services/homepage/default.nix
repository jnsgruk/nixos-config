{ hostname, lib, pkgs, outputs, ... }:
{
  # Remove once https://github.com/NixOS/nixpkgs/pull/291554 is merged.
  disabledModules = [ "services/misc/homepage-dashboard.nix" ];
  imports = [ outputs.nixosModules.homepage-dashboard ]
    ++ lib.optional (builtins.pathExists (./. + "/${hostname}.nix")) ./${hostname}.nix;

  services.homepage-dashboard = {
    enable = true;
    package = pkgs.homepage-dashboard-patched;
    openFirewall = true;
  };
}

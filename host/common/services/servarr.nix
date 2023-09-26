{ inputs, pkgs, ... }:
let
  prowlarrModule = "nixos/modules/services/misc/prowlarr.nix";
in
{
  # Always use the prowlarr module from nixos-unstable
  disabledModules = [ "${inputs.nixpkgs}/${prowlarrModule}" ];
  imports = [ "${inputs.nixpkgs-unstable}/${prowlarrModule}" ];

  services = {
    jellyfin = {
      enable = true;
      package = pkgs.unstable.jellyfin;
      group = "users";
    };
    prowlarr = {
      enable = true;
      package = pkgs.unstable.prowlarr;
      openFirewall = true;
    };
    radarr = {
      enable = true;
      package = pkgs.unstable.radarr;
      openFirewall = true;
      group = "users";
    };
    sabnzbd = {
      enable = true;
      package = pkgs.unstable.sabnzbd;
      group = "users";
    };
    sonarr = {
      enable = true;
      package = pkgs.unstable.sonarr;
      openFirewall = true;
      group = "users";
    };
  };
}

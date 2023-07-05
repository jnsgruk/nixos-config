{ pkgs, lib, hostname, ... }: {
  imports = [ ]
    ++ lib.optional (builtins.pathExists (./. + "/${hostname}.nix")) ./${hostname}.nix;

  services = {
    prowlarr = {
      enable = true;
      openFirewall = true;
      # package = pkgs.unstable.prowlarr;
      # group = "users";
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

  users = {
    users.prowlarr = {
      group = "prowlarr";
      uid = 282;
    };
    groups.prowlarr.gid = 282;
  };
}

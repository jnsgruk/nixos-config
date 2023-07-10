{ pkgs, lib, ... }:
let
  dataDir = "/data/apps";
  prowlarr = pkgs.unstable.prowlarr;
in
{
  services = {
    sonarr.dataDir = "${dataDir}/sonarr";
    radarr.dataDir = "${dataDir}/radarr";
    sabnzbd.configFile = "${dataDir}/sabnzbd/sabnzbd.ini";
    # prowlarr.dataDir = "${dataDir}/prowlarr";
  };

  systemd.services = {
    prowlarr = {
      serviceConfig = {
        DynamicUser = lib.mkForce false;
        User = "prowlarr";
        Group = "users";
        ExecStart = lib.mkForce "${prowlarr}/bin/Prowlarr -nobrowser -data=/data/apps/prowlarr";
      };
    };
  };
}

{ pkgs, lib, ... }:
let
  dataDir = "/data/apps";
  port = "8082";
  homepageId = 272;
in
{
  networking.firewall = {
    allowedTCPPorts = [ (lib.strings.toInt port) ];
  };

  users = {
    users.homepage = {
      group = "homepage";
      home = "${dataDir}/homepage";
      uid = homepageId;
    };

    groups.homepage = {
      gid = homepageId;
    };
  };

  systemd.services.homepage = {
    enable = true;
    description = "A highly customizable homepage (or startpage / application dashboard) with Docker and service API integrations.";
    environment = {
      HOMEPAGE_CONFIG_DIR = "${dataDir}/homepage";
      PORT = "${port}";
    };
    serviceConfig = {
      Type = "simple";
      User = "homepage";
      Group = "homepage";
      ExecStart = "${pkgs.homepage}/bin/homepage";
      Restart = "on-failure";
    };
    wantedBy = [ "multi-user.target" ];
  };
}

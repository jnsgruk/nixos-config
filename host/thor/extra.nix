{ lib, ... }: {
  imports = [
    ../common/services/files.nix
    ../common/services/homepage.nix
    ../common/services/servarr.nix
    ../common/services/traefik
  ];

  services = {
    cron = {
      enable = true;
      systemCronJobs = [
        "@daily    root    /data/apps/backup.sh > /data/apps/backup.log"
      ];
    };

    duplicati.enable = true;

    syncthing = {
      enable = true;
      guiAddress = "thor.tailnet-d5da.ts.net:8384";
      configDir = "/data/apps/syncthing";
      user = "jon";
      group = "users";
    };
  };

  systemd.services.duplicati.serviceConfig = {
    Group = lib.mkForce "users";
    User = lib.mkForce "jon";
  };
}


{ lib, ... }: {
  imports = [
    ../common/services/files.nix
    ../common/services/homepage.nix
    ../common/services/servarr.nix
    ../common/services/traefik
    ../common/virt
  ];

  # Firewall port for NFS
  networking.firewall = {
    allowedTCPPorts = [ 111 2049 4000 4001 4002 20048 ];
    allowedUDPPorts = [ 111 2049 4000 4001 4002 20048 ];
  };

  services = {
    cron = {
      enable = true;
      systemCronJobs = [
        "@daily    root    /data/apps/backup.sh > /data/apps/backup.log"
      ];
    };

    duplicati.enable = true;

    nfs = {
      server = {
        enable = true;
        exports = ''
          /data/media  100.64.0.0/10 (rw,fsid=0,no_subtree_check)
        '';
      };
    };

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


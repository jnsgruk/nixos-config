{ config, self, ... }:
{
  imports = [
    ../common/services/files.nix
    ../common/services/home-assistant.nix
    ../common/services/libations.nix
    ../common/services/homepage
    ../common/services/photo-backup
    ../common/services/servarr
    ../common/services/traefik
  ];

  age.secrets = {
    borgbase-ssh = {
      file = "${self}/secrets/thor-borgbase-ssh.age";
      owner = "root";
      group = "root";
      mode = "400";
    };
    borgbase-passphrase = {
      file = "${self}/secrets/thor-borgbase-passphrase.age";
      owner = "root";
      group = "root";
      mode = "400";
    };
  };

  networking.firewall = {
    allowedTCPPorts = [
      111
      2049
      4000
      4001
      4002
      20048
    ];
    allowedUDPPorts = [
      111
      2049
      4000
      4001
      4002
      20048
    ];
  };

  services = {
    # In order to mount the backup to restore files, perform the following:
    #
    #    mkdir backup
    #    sudo borg-job-borgbase mount ike67cye@ike67cye.repo.borgbase.com:repo ./backup
    # 
    # Then copy out the files you need using normal Linux commands. Once complete, unmount
    # with:
    #
    #    borg-job-borgbase umount backup
    borgbackup.jobs."borgbase" = {
      paths = [
        "/data"
        "/var/lib/homepage-dashboard"
        "/var/lib/nixos-containers/radarr/var/lib/radarr"
        "/var/lib/nixos-containers/sonarr/var/lib/sonarr"
        "/var/lib/nixos-containers/prowlarr/var/lib/prowlarr"
        "/var/lib/nixos-containers/jellyfin/var/lib/jellyfin"
        "/var/lib/nixos-containers/sabnzbd/var/lib/sabnzbd"
      ];
      exclude = [
        "/data/apps/files/_files/cache"
        "/data/lost+found"
        "/data/media"
      ];
      repo = "ike67cye@ike67cye.repo.borgbase.com:repo";
      encryption = {
        mode = "repokey-blake2";
        passCommand = "cat ${config.age.secrets."borgbase-passphrase".path}";
      };
      environment.BORG_RSH = "ssh -i ${config.age.secrets."borgbase-ssh".path}";
      compression = "auto,lzma";
      startAt = "daily";
    };

    nfs = {
      server = {
        enable = true;
        exports = ''
          /data  100.64.0.0/10 (rw,fsid=0,no_subtree_check)
        '';
      };
    };
  };
}

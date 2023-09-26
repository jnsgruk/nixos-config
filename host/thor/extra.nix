{ lib, config, ... }: {
  imports = [
    ../common/services/files.nix
    ../common/services/homepage.nix
    ../common/services/servarr.nix
    ../common/services/traefik
  ];

  age.secrets = {
    borgbase-ssh = {
      file = ../../secrets/borgbase-ssh.age;
      owner = "root";
      group = "root";
      mode = "400";
    };
    borgbase-passphrase = {
      file = ../../secrets/borgbase-passphrase.age;
      owner = "root";
      group = "root";
      mode = "400";
    };
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
        "/var/lib/radarr"
        "/var/lib/sonarr"
        "/var/lib/prowlarr"
        "/var/lib/jellyfin"
        "/var/lib/sanzbd"
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
  };
}


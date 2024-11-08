{
  pkgs,
  lib,
  config,
  self,
  ...
}:
let
  photo-backup = pkgs.writeShellApplication {
    name = "photo-backup";
    runtimeInputs = with pkgs; [
      bash
      curl
      gphotos-sync
      master.icloudpd
      urlencode
    ];
    text = builtins.readFile ./photo-backup.sh;
  };
in
{
  age.secrets = {
    backup-env = {
      file = "${self}/secrets/thor-backup-env.age";
      owner = "root";
      group = "root";
      mode = "400";
    };
  };

  environment.systemPackages = [ photo-backup ];

  systemd = {
    services.photo-backup = {
      description = "Photo Backup Service";
      after = [ "network.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${lib.getExe photo-backup}";
        EnvironmentFile = config.age.secrets."backup-env".path;
      };
      startAt = "*-*-* 21:00:00";
    };

    timers.photo-backup.timerConfig.Persistent = true;
  };
}

{
  config,
  hostname,
  lib,
  self,
  ...
}:
{
  imports = lib.optional (builtins.pathExists (./. + "/${hostname}.nix")) ./${hostname}.nix;

  age.secrets = {
    borgbase-ssh = {
      file = "${self}/secrets/${hostname}-borgbase-ssh.age";
      owner = "root";
      group = "root";
      mode = "400";
    };
    borgbase-passphrase = {
      file = "${self}/secrets/${hostname}-borgbase-passphrase.age";
      owner = "root";
      group = "root";
      mode = "400";
    };
  };

  # See individual host config files for backup/restore instructions.
  services.borgbackup.jobs."borgbase" = {
    encryption = {
      mode = "repokey-blake2";
      passCommand = "cat ${config.age.secrets."borgbase-passphrase".path}";
    };
    environment.BORG_RSH = "ssh -i ${config.age.secrets."borgbase-ssh".path}";
    compression = "auto,lzma";
  };
}

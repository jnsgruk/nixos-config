_: {
  # In order to mount the backup to restore files, perform the following:
  #
  #    mkdir backup
  #    sudo borg-job-borgbase mount ike67cye@ike67cye.repo.borgbase.com:repo ./backup
  #
  # Then copy out the files you need using normal Linux commands. Once complete, unmount
  # with:
  #
  #    borg-job-borgbase umount backup
  services.borgbackup.jobs."borgbase" = {
    paths = [ "/data" ];
    exclude = [
      "/data/apps/files/_files/cache"
      "/data/lost+found"
      "/data/media"
    ];
    repo = "ike67cye@ike67cye.repo.borgbase.com:repo";
    startAt = "daily";
  };
}

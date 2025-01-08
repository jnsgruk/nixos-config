_: {

  # In order to mount the backup to restore files, perform the following:
  #
  #    mkdir backup
  #    sudo borg-job-borgbase mount z2sqv4mw@z2sqv4mw.repo.borgbase.com:repo ./backup
  #
  # Then copy out the files you need using normal Linux commands. Once complete, unmount
  # with:
  #
  #    borg-job-borgbase umount backup
  services.borgbackup.jobs."borgbase" = {
    paths = [ "/home/jon/data" ];
    exclude = [
      "**/node_modules"
      "**/build"
      "**/dist"
      "**/.tox"
      "**/.venv"
      "**/venv"
      "**/target"
      "/home/jon/downloads"
      "/home/jon/data/downloads"
      "/home/jon/data/temp"
      "/home/jon/go"
      "/home/jon/sdk"
    ];
    repo = "z2sqv4mw@z2sqv4mw.repo.borgbase.com:repo";
    startAt = "*-*-* 12:00:00";
  };
}

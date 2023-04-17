{ ... }: {
  services.syncthing = {
    enable = true;
    extraOptions = [
      "-gui-address=100.125.106.101:8384"
      "-home=/home/jon/data/.syncthing"
    ];
  };
}

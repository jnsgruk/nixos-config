{ ... }: {
  services.syncthing = {
    enable = true;
    extraOptions = [
      "-gui-address=100.93.165.28:8384"
      "-home=/home/jon/data/.syncthing"
    ];
  };
}

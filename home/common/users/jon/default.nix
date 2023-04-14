{ ... }: {
  services.syncthing = {
    enable = true;
    extraOptions = [
      "-gui-address=0.0.0.0:8384"
      "-home=/home/jon/data/.syncthing"
    ];
  };
}

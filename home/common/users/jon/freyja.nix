{ ... }: {
  services.syncthing = {
    enable = true;
    extraOptions = [
      "-gui-address=100.78.135.96:8384"
      "-home=/home/jon/data/.syncthing"
    ];
  };
}

_: {
  services.syncthing = {
    enable = true;
    extraOptions = [
      "-gui-address=kara.tailnet-d5da.ts.net:8384"
      "-home=/home/jon/data/.syncthing"
    ];
  };
}

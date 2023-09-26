_: {
  services.syncthing = {
    enable = true;
    extraOptions = [
      "-gui-address=thor.tailnet-d5da.ts.net:8384"
      "-home=/data/apps/syncthing"
    ];
  };
}

{ ... }: {
  imports = [
    ../common/global
    ../common/optional/desktop
    ../common/optional/sway
  ];

  services.syncthing = {
    enable = true;
    extraOptions = [
      "-gui-address=100.73.28.58:8384"
      "-home=/home/jon/data/.syncthing"
    ];
  };
}

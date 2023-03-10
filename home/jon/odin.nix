{ ... }: {
  imports = [
    ../common/global
    ../common/optional/desktop
    ../common/optional/dev
    ../common/optional/sway
  ];

  services.syncthing = {
    enable = true;
    extraOptions = [
      "-gui-address=100.124.10.79:8384"
      "-home=/home/jon/data/.syncthing"
    ];
  };
}

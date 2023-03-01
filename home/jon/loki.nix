{ ... }: {
  imports = [
    ../common/global
    ../common/optional/charm-tools.nix
    ../common/optional/desktop
    ../common/optional/dev
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

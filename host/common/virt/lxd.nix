{ pkgs, ... }: {
  virtualisation = {
    lxd = {
      enable = true;
      zfsSupport = true;
    };
  };

  systemd.services.lxd.environment = {
    "LXD_UI" = "${pkgs.lxd-ui}/ui";
  };
}

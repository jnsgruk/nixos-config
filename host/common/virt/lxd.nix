{ pkgs, ... }: {
  virtualisation = {
    lxd = {
      enable = true;
      zfsSupport = true;
      ui.enable = true;
    };
  };
}

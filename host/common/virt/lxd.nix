{ pkgs, ... }: {
  virtualisation = {
    lxd = {
      enable = true;
      zfsSupport = true;
    };
  };
}

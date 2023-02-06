{ pkgs, ... }: {
  programs = {
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
  };

  services = {
    gvfs.enable = true;
    # Enable thumbnails in Thunar
    tumbler.enable = true;
  };
}

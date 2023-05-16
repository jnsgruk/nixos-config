{ pkgs, ... }: {
  qt = {
    enable = true;
    platformTheme = "gtk";
  };

  home = {
    packages = with pkgs; [
      (catppuccin-kvantum.override { variant = "Macchiato"; accent = "Blue"; })
      libsForQt5.qtstyleplugin-kvantum
    ];
    sessionVariables = {
      "QT_STYLE_OVERRIDE" = "kvantum";
    };
  };

  xdg.configFile = {
    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=Catppuccin-Macchiato-Blue
    '';
  };
}

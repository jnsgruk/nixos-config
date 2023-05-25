{ pkgs, theme, ... }:
let
  defaults = theme { inherit pkgs; };
in
{
  qt = {
    enable = true;
    platformTheme = "gtk";
  };

  home = {
    packages = with pkgs; [
      defaults.qtTheme.package
      libsForQt5.qtstyleplugin-kvantum
    ];
    sessionVariables = {
      "QT_STYLE_OVERRIDE" = "kvantum";
    };
  };

  xdg.configFile = {
    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=${defaults.qtTheme.name}
    '';
  };
}

{ theme
, pkgs
, config
, ...
}:
let
  defaults = theme { inherit pkgs; };
in
{
  home.pointerCursor = {
    package = defaults.cursorTheme.package;
    name = "${defaults.cursorTheme.name}";
    size = defaults.cursorTheme.size;
    gtk.enable = true;
    x11.enable = true;
  };

  gtk = {
    enable = true;

    font = {
      name = "${defaults.fonts.default.name}, ${defaults.fonts.default.size}";
      package = defaults.fonts.default.package;
    };

    gtk2 = {
      configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
      extraConfig = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk3.extraConfig = {
      gtk-button-images = 1;
      gtk-application-prefer-dark-theme = true;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };

    iconTheme = {
      name = defaults.iconTheme.name;
      package = defaults.iconTheme.package;
    };

    theme = defaults.gtkTheme;
  };
}

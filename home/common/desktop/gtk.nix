{ theme
, config
, ...
}: {
  home.pointerCursor = {
    package = theme.cursorTheme.package;
    name = "${theme.cursorTheme.name}";
    size = theme.cursorTheme.size;
    gtk.enable = true;
    x11.enable = true;
  };

  gtk = {
    enable = true;

    font = {
      name = "${theme.fonts.default.name}, ${theme.fonts.default.size}";
      package = theme.fonts.default.package;
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
      name = theme.iconTheme.name;
      package = theme.iconTheme.package;
    };

    theme = theme.gtkTheme;
  };
}

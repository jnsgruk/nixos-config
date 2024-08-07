{
  pkgs,
  self,
  config,
  ...
}:
let
  theme = import "${self}/lib/theme" { inherit pkgs; };
in
{
  home.pointerCursor = {
    inherit (theme.cursorTheme) package size name;
    gtk.enable = true;
    x11.enable = true;
  };

  gtk = {
    enable = true;

    theme = theme.gtkTheme;

    font = {
      inherit (theme.fonts.default) package;
      name = "${theme.fonts.default.name}, ${theme.fonts.default.size}";
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
      inherit (theme.iconTheme) name package;
    };
  };
}

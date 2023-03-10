{ pkgs
, config
, ...
}:
let
  theme = "Catppuccin-Macchiato-Standard-Blue-Dark";
in
{
  inherit theme;

  home.pointerCursor = {
    package = pkgs.gnome.adwaita-icon-theme;
    name = "Adwaita";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  gtk = {
    enable = true;

    font = {
      name = "SF Pro, 11";
      package = pkgs.sfpro-font;
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
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    theme = {
      name = "${theme}";
      package = pkgs.catppuccin-gtk.override {
        size = "standard";
        variant = "macchiato";
        accents = [ "blue" ];
      };
    };
  };
}

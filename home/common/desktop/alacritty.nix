{ ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      env = {
        TERM = "alacritty";
      };

      window = {
        padding = {
          x = 20;
          y = 20;
        };
      };

      decorations = "none";
      dynamic_title = true;
      gtk_theme_variant = "dark";
      live_config_reload = true;

      scrolling.history = 100000;

      font = {
        normal.family = "MesloLGMDZ Nerd Font Mono";
        size = 14;
      };

      colors = {
        # Default colors
        primary = {
          background = "#24273A";
          foreground = "#CAD3F5";
          dim_foreground = "#CAD3F5";
          bright_foreground = "#CAD3F5";
        };

        # Cursor colors
        cursor = {
          text = "#24273A"; # base
          cursor = "#F4DBD6"; # rosewater
        };

        vi_mode_cursor = {
          text = "#24273A"; # base
          cursor = "#B7BDF8"; # lavender
        };

        # Search colors
        search = {
          matches = {
            foreground = "#24273A"; # base
            background = "#A5ADCB"; # subtext0
          };
          focused_match = {
            foreground = "#24273A"; # base
            background = "#A6DA95"; # green
          };
          footer_bar = {
            foreground = "#24273A"; # base
            background = "#A5ADCB"; # subtext0
          };
        };

        # Keyboard regex hints
        hints = {
          start = {
            foreground = "#24273A"; # base
            background = "#EED49F"; # yellow
          };
          end = {
            foreground = "#24273A"; # base
            background = "#A5ADCB"; # subtext0
          };
        };

        # Selection colors
        selection = {
          text = "#24273A"; # base
          background = "#F4DBD6"; # rosewater
        };

        # Normal colors
        normal = {
          black = "#494D64"; # surface1
          red = "#ED8796"; # red
          green = "#A6DA95"; # green
          yellow = "#EED49F"; # yellow
          blue = "#8AADF4"; # blue
          magenta = "#F5BDE6"; # pink
          cyan = "#8BD5CA"; # teal
          white = "#B8C0E0"; # subtext1
        };

        # Bright colors
        bright = {
          black = "#5B6078"; # surface2
          red = "#ED8796"; # red
          green = "#A6DA95"; # green
          yellow = "#EED49F"; # yellow
          blue = "#8AADF4"; # blue
          magenta = "#F5BDE6"; # pink
          cyan = "#8BD5CA"; # teal
          white = "#A5ADCB"; # subtext0
        };

        # Dim colors
        dim = {
          black = "#494D64"; # surface1
          red = "#ED8796"; # red
          green = "#A6DA95"; # green
          yellow = "#EED49F"; # yellow
          blue = "#8AADF4"; # blue
          magenta = "#F5BDE6"; # pink
          cyan = "#8BD5CA"; # teal
          white = "#B8C0E0"; # subtext1
        };

        indexed_colors = [
          {
            index = 16;
            color = "#F5A97F";
          }
          {
            index = 17;
            color = "#F4DBD6";
          }
        ];
      };
    };
  };
}

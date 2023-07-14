{ theme, ... }:
let
  inherit (theme) colours;
in
{
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
        normal.family = "${theme.fonts.monospace.name}";
        size = 14;
      };

      colors = {
        # Default colors
        primary = {
          background = "${colours.bg}";
          foreground = "${colours.text}";
          dim_foreground = "${colours.text}";
          bright_foreground = "${colours.text}";
        };

        # Cursor colors
        cursor = {
          text = "${colours.bg}";
          cursor = "${colours.white}";
        };

        vi_mode_cursor = {
          text = "${colours.bg}";
          cursor = "${colours.lightPurple}";
        };

        # Search colors
        search = {
          matches = {
            foreground = "${colours.bg}";
            background = "${colours.subtext0}";
          };
          focused_match = {
            foreground = "${colours.bg}";
            background = "${colours.green}";
          };
          footer_bar = {
            foreground = "${colours.bg}";
            background = "${colours.subtext0}";
          };
        };

        # Keyboard regex hints
        hints = {
          start = {
            foreground = "${colours.bg}";
            background = "${colours.yellow}";
          };
          end = {
            foreground = "${colours.bg}";
            background = "${colours.subtext0}";
          };
        };

        # Selection colors
        selection = {
          text = "${colours.bg}";
          background = "${colours.white}";
        };

        # Normal colors
        normal = {
          black = "${colours.surface1}";
          red = "${colours.red}";
          green = "${colours.green}";
          yellow = "${colours.yellow}";
          blue = "${colours.darkBlue}";
          magenta = "${colours.pink}";
          cyan = "${colours.cyan}";
          white = "${colours.subtext1}";
        };

        # Bright colors
        bright = {
          black = "${colours.surface2}";
          red = "${colours.red}";
          green = "${colours.green}";
          yellow = "${colours.yellow}";
          blue = "${colours.darkBlue}";
          magenta = "${colours.pink}";
          cyan = "${colours.cyan}";
          white = "${colours.subtext0}";
        };

        # Dim colors
        dim = {
          black = "${colours.surface1}";
          red = "${colours.red}";
          green = "${colours.green}";
          yellow = "${colours.yellow}";
          blue = "${colours.darkBlue}";
          magenta = "${colours.pink}";
          cyan = "${colours.cyan}";
          white = "${colours.subtext1}";
        };

        indexed_colors = [
          {
            index = 16;
            color = "${colours.orange}";
          }
          {
            index = 17;
            color = "${colours.white}";
          }
        ];
      };
    };
  };
}

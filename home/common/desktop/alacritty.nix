{ pkgs, self, ... }:
let
  theme = import "${self}/lib/theme" { inherit pkgs; };
in
{
  catppuccin.alacritty.enable = true;

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

      general = {
        live_config_reload = true;
      };

      scrolling.history = 100000;

      font = {
        normal.family = "${theme.fonts.monospace.name}";
        size = 14;
      };
    };
  };
}

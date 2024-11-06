{ pkgs, self, ... }:
let
  theme = import "${self}/lib/theme" { inherit pkgs; };
in
{
  programs.alacritty = {
    enable = true;
    catppuccin.enable = true;
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

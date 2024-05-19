{
  self,
  lib,
  pkgs,
  hostname,
  ...
}:
let
  theme = import "${self}/lib/theme" { inherit pkgs hostname; };
  inherit (theme) hexToRgb colours;
in
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        grace = 5;
        hide_cursor = true;
      };

      background = [
        {
          path = "${theme.wallpaper}";
          blur_passes = 2;
          blur_size = 6;
        }
      ];

      input-field = [
        {
          size = "250, 60";
          outer_color = "rgb(${hexToRgb colours.black})";
          inner_color = "rgb(${hexToRgb colours.bgDark})";
          font_color = "rgb(${hexToRgb colours.purple})";
          placeholder_text = "";
        }
      ];

      label = [
        {
          text = "Hello";
          color = "rgba(${hexToRgb colours.text}, 1.0)";
          font_family = theme.fonts.default.name;
          font_size = 64;
          text_align = "center";
          halign = "center";
          valign = "center";
          position = "0, 160";
        }
        {
          text = "$TIME";
          color = "rgba(${hexToRgb colours.subtext1}, 1.0)";
          font_family = theme.fonts.default.name;
          font_size = 32;
          text_align = "center";
          halign = "center";
          valign = "center";
          position = "0, 75";
        }
      ];
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "${lib.getExe pkgs.hyprlock}";
        before_sleep_cmd = "${lib.getExe pkgs.hyprlock}";
      };

      listener = [
        {
          timeout = 300;
          on-timeout = "${lib.getExe pkgs.hyprlock}";
        }
        {
          timeout = 305;
          on-timeout = "${pkgs.hyprland}/bin/hyprctl dispatch dpms off";
          on-resume = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
        }
      ];
    };
  };
}

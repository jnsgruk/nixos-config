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

    general = {
      grace = 5;
      hide_cursor = true;
    };

    backgrounds = [
      {
        path = "${theme.wallpaper}";
        blur_passes = 2;
        blur_size = 6;
      }
    ];

    input-fields = [
      {
        size.width = 250;
        outer_color = "rgb(${hexToRgb colours.black})";
        inner_color = "rgb(${hexToRgb colours.bgDark})";
        font_color = "rgb(${hexToRgb colours.purple})";
        placeholder_text = "";
      }
    ];

    labels = [
      {
        text = "Hello";
        color = "rgba(${hexToRgb colours.text}, 1.0)";
        font_family = theme.fonts.default.name;
        font_size = 64;
      }
      {
        text = "$TIME";
        color = "rgba(${hexToRgb colours.subtext1}, 1.0)";
        font_family = theme.fonts.default.name;
        font_size = 32;
        position.y = 160;
      }
    ];
  };

  services.hypridle = {
    enable = true;
    lockCmd = "${lib.getExe pkgs.hyprlock}";
    beforeSleepCmd = "${lib.getExe pkgs.hyprlock}";
    listeners = [
      {
        timeout = 300;
        onTimeout = "${lib.getExe pkgs.hyprlock}";
      }
      {
        timeout = 305;
        onTimeout = "${pkgs.hyprland}/bin/hyprctl dispatch dpms off";
        onResume = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
      }
    ];
  };
}

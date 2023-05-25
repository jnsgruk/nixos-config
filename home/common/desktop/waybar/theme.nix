{ config, pkgs, lib, theme, ... }: {
  theme =
    let
      inherit (config.lib.formats.rasi) mkLiteral;
      defaults = theme { inherit pkgs; };
      colours = defaults.colours;
    in
    {
      "*" = {
        border = mkLiteral "none";
        padding = 0;
        font-family = "${defaults.fonts.iconFont.name}";
        font-size = 15;
      };

      "window#waybar" = {
        background-color = mkLiteral "transparent";
      };

      "window>box" = {
        margin = mkLiteral "8 8 0 8";
        background = mkLiteral "${colours.bg}";
        opacity = mkLiteral "0.8";
        border-radius = 8;
      };

      ".modules-right" = {
        margin-right = 10;
        padding = mkLiteral "5 10";
      };

      ".modules-center" = {
        margin = 0;
        padding = mkLiteral "5 10";
      };

      ".modules-left" = {
        margin-left = 10;
        padding = mkLiteral "5 0";
      };

      "#workspaces button" = {
        padding = mkLiteral "0 10";
        background-color = mkLiteral "transparent";
        font-weight = mkLiteral "lighter";
        color = mkLiteral "${colours.text}";
      };

      "#workspaces button:hover" = {
        color = mkLiteral "${colours.accent}";
        background-color = mkLiteral "transparent";
      };

      "#workspaces button.focused, #workspaces button.active" = {
        color = mkLiteral "${colours.accent}";
        font-weight = mkLiteral "normal";
        background-color = mkLiteral "transparent";
      };

      "#clock,
      #battery,
      #cpu,
      #memory,
      #temperature,
      #network,
      #pulseaudio,
      #custom-media,
      #tray,
      #mode,
      #custom-power,
      #custom-menu,
      #idle_inhibitor" = {
        padding = mkLiteral "0 10";
        color = mkLiteral "${colours.text}";
      };

      "#mode" = {
        font-weight = mkLiteral "bold";
      };

      "#custom-power" = {
        color = mkLiteral "${colours.accent}";
        background-color = mkLiteral "transparent";
      };

      /*-----Indicators----*/
      "#idle_inhibitor.activated" = {
        color = mkLiteral "${colours.accent}";
      };

      "#battery.charging" = {
        color = mkLiteral "${colours.green}";
      };

      "#battery.warning:not(.charging)" = {
        color = mkLiteral "${colours.orange}";
      };

      "#battery.critical:not(.charging)" = {
        color = mkLiteral "${colours.red}";
      };

      "#temperature.critical" = {
        color = mkLiteral "${colours.red}";
      };
    };
}

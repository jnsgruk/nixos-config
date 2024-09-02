{
  config,
  lib,
  theme,
  desktop,
  ...
}:
{
  theme =
    let
      inherit (config.lib.formats.rasi) mkLiteral;
    in
    {
      "*" = {
        border = mkLiteral "none";
        padding = mkLiteral "0px";
        font-family = "${theme.fonts.iconFont.name}";
        font-size = mkLiteral "15px";
      };

      "window#waybar" = {
        background-color = mkLiteral "transparent";
      };

      "window>box" = {
        margin = mkLiteral "8px 8px 0px 8px";
        background = mkLiteral "${theme.colours.bg}";
        opacity = mkLiteral "0.8";
        border-radius = mkLiteral "8px";
      };

      ".modules-right" = {
        margin-right = mkLiteral "10px";
        padding = mkLiteral "5px 10px";
      };

      ".modules-center" = {
        margin = mkLiteral "0px";
        padding = mkLiteral "5px 10px";
      };

      ".modules-left" = {
        margin-left = mkLiteral "10px";
        padding = mkLiteral "5px 0px";
      };

      "#workspaces button" = {
        padding = if desktop == "hyprland" then mkLiteral "0px 10px" else mkLiteral "0px";
        background-color = mkLiteral "transparent";
        font-weight = mkLiteral "lighter";
        color = mkLiteral "${theme.colours.text}";
      };

      "#workspaces button:hover" = {
        color = mkLiteral "${theme.colours.accent}";
        background-color = mkLiteral "transparent";
      };

      "#workspaces button.focused, #workspaces button.active" = {
        color = mkLiteral "${theme.colours.accent}";
        font-weight = mkLiteral "normal";
        background-color = mkLiteral "transparent";
      };

      "#battery,
      #bluetooth,
      #clock,
      #cpu,
      #custom-lock,
      #custom-power,
      #custom-quit,
      #custom-reboot,
      #custom-vpn,
      #group-group-power,
      #idle_inhibitor,
      #memory,
      #network,
      #pulseaudio,
      #wireplumber" = {
        padding = mkLiteral "0px 10px";
        color = mkLiteral "${theme.colours.text}";
      };

      "#custom-vpn.tailnet" = {
        color = mkLiteral "${theme.colours.blue}";
        background-color = mkLiteral "transparent";
      };
      "#custom-vpn.exitNode" = {
        color = mkLiteral "${theme.colours.green}";
        background-color = mkLiteral "transparent";
      };
      "#custom-vpn.disconnected" = {
        color = mkLiteral "${theme.colours.red}";
        background-color = mkLiteral "transparent";
      };

      "#custom-power" = {
        color = mkLiteral "${theme.colours.accent}";
        background-color = mkLiteral "transparent";
      };

      "#custom-quit, #custom-lock, #custom-reboot" = {
        color = mkLiteral "${theme.colours.red}";
        background-color = mkLiteral "transparent";
      };

      # -----Indicators----
      "#idle_inhibitor.activated" = {
        color = mkLiteral "${theme.colours.accent}";
      };

      "#battery.charging" = {
        color = mkLiteral "${theme.colours.green}";
      };

      "#battery.warning:not(.charging)" = {
        color = mkLiteral "${theme.colours.orange}";
      };

      "#battery.critical:not(.charging)" = {
        color = mkLiteral "${theme.colours.red}";
      };

      "#temperature.critical" = {
        color = mkLiteral "${theme.colours.red}";
      };

      "#bluetooth.off" = {
        color = mkLiteral "${theme.colours.orange}";
      };

      "#wireplumber.muted" = {
        color = mkLiteral "${theme.colours.orange}";
      };

      "#pulseaudio.source-muted" = {
        color = mkLiteral "${theme.colours.orange}";
      };
    };
}

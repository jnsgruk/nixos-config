{ pkgs, lib, hostname, desktop, ... }:
let
  # If this is a laptop, then include network/battery controls
  modules =
    if hostname == "freyja" then [
      "tray"
      "network"
      "battery"
      "pulseaudio"
      "pulseaudio#source"
      "custom/power"
    ]
    else [
      "tray"
      "pulseaudio"
      "pulseaudio#source"
      "custom/power"
    ];
in
{
  programs.waybar = {
    enable = true;

    systemd = {
      enable = if desktop == "sway" then true else false;
    };

    settings = [{
      exclusive = true;
      position = "top";
      height = 18;
      passthrough = false;
      gtk-layer-shell = true;

      modules-left = [ "sway/workspaces" ];
      modules-center = [ "clock" "idle_inhibitor" ];
      modules-right = modules;

      "sway/workspaces" = {
        format = "{icon}";
        format-icons = {
          "1" = "";
          "2" = "";
          "3" = "";
          "4" = "";
          "5" = "";
          "6" = "";
          "7" = "";
        };
      };

      "network" = {
        format-wifi = "{essid} ";
        format-ethernet = "{ifname} ";
        format-disconnected = "";
        tooltip-format = "{ifname} / {essid} ({signalStrength}%) / {ipaddr}";
        max-length = 15;
        on-click = "${pkgs.alacritty}/bin/alacritty -e ${pkgs.networkmanager}/bin/nmtui";
      };

      "idle_inhibitor" = {
        format = "{icon}";
        format-icons = {
          activated = "";
          deactivated = "";
        };
      };

      "battery" = {
        states = {
          good = 95;
          warning = 20;
          critical = 10;
        };
        format = "{capacity}% {icon}";
        format-charging = "{capacity}% ";
        format-plugged = "";
        tooltip-format = "{time} ({capacity}%)";
        format-alt = "{time} {icon}";
        format-full = "";
        format-icons = [ "" "" "" "" "" ];
      };

      "tray" = {
        icon-size = 15;
        spacing = 10;
      };

      "clock" = { format = "{:%d %b %H:%M}"; };

      "pulseaudio" = {
        format = "{volume}% {icon}";
        format-bluetooth = "{volume}% {icon} {format_source}";
        format-bluetooth-muted = " {icon} {format_source}";
        format-muted = "";
        format-icons = {
          headphone = "";
          hands-free = "";
          headset = "";
          phone = "";
          portable = "";
          car = "";
          default = [ "" "" "" ];
        };
        on-click = "${pkgs.avizo}/bin/volumectl toggle-mute";
        on-click-right = "${pkgs.pavucontrol}/bin/pavucontrol";
        tooltip-format = "{volume}% / {desc}";
      };

      "pulseaudio#source" = {
        format = "{format_source}";
        format-source = "";
        format-source-muted = "";
        on-click = "${pkgs.avizo}/bin/volumectl -m toggle-mute";
        on-click-right = "${pkgs.pavucontrol}/bin/pavucontrol";
        tooltip-format = "{source_volume}% / {desc}";
      };

      "custom/power" = {
        format = "";
        on-click = "${lib.getExe (import ../rofi/powermenu { inherit lib desktop pkgs; }).rofi-power} ${desktop}";
      };
    }];

    style = builtins.readFile ./waybar.css;
  };
}

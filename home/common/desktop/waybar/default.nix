{ config, pkgs, lib, hostname, desktop, theme, ... }:
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

  workspaceConfig = {
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
    on-click = "activate";
  };

  inherit ((import ../rofi/lib.nix { inherit lib; })) toRasi;
  inherit ((import ../rofi/powermenu { inherit config lib desktop pkgs theme; })) rofi-power;
in
{
  programs.waybar = {
    enable = true;
    package = if desktop == "hyprland" then pkgs.waybar-hyprland else pkgs.waybar;

    systemd = {
      enable = true; #if desktop == "sway" then true else false;
    };

    settings = [{
      exclusive = true;
      position = "top";
      height = 18;
      passthrough = false;
      gtk-layer-shell = true;

      modules-left = [ (if desktop == "sway" then "sway/workspaces" else "wlr/workspaces") ];
      modules-center = [ "clock" "idle_inhibitor" ];
      modules-right = modules;

      "sway/workspaces" = workspaceConfig;
      "wlr/workspaces" = workspaceConfig;

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
        on-click = "${lib.getExe rofi-power} ${desktop}";
      };
    }];

    # This is a bit of a hack. Rasi turns out to be basically CSS, and there is
    # a handy helper to convert nix -> rasi in the home-manager module for rofi,
    # so I'm using that here to render the stylesheet for waybar
    style = toRasi (import ./theme.nix { inherit config pkgs lib theme; }).theme;
  };

  # This is a hack to ensure that hyprctl ends up in the PATH for the waybar service on hyprland
  systemd.user.services.waybar.Service.Environment = lib.mkForce "PATH=${lib.makeBinPath [pkgs."${desktop}"]}";
}

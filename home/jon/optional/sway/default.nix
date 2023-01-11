{
  pkgs,
  lib,
  config,
  default,
  ...
}: {
  imports = [
    ./mako.nix
    ./swaybg.nix
    ./swaylock.nix
    ./zathura.nix
    ./waybar.nix
  ];

  home.packages = with pkgs; [
    grim
    playerctl
    slurp
    swaybg
    wf-recorder
    wl-clipboard
    wofi
  ];

  home.sessionVariables = {
    _JAVA_AWT_WM_NONREPARENTING = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
  };

  wayland.windowManager.sway = {
    enable = true;
    # package = inputs.self.packages.${pkgs.system}.sway-hidpi;
    config = {
      menu = "wofi";
      terminal = "alacritty";
      modifier = "Mod4";
      bars = [];

      gaps = {
        smartBorders = "on";
        outer = 4;
        inner = 4;
      };

      startup = [{command = "dbus-update-activation-environment --systemd WAYLAND_DISPLAY DISPLAY";}];

      input = {
        "type:pointer" = {
          accel_profile = "flat";
          pointer_accel = "0";
        };
        "type:touchpad" = {
          middle_emulation = "enabled";
          natural_scroll = "enabled";
          tap = "enabled";
        };
      };
      output."*".bg = "~/.config/wallpaper.png fill";
    };

    wrapperFeatures.gtk = true;
  };

  # fake a tray to let apps start
  # https://github.com/nix-community/home-manager/issues/2064
  #   systemd.user.targets.tray = {
  #     Unit = {
  #       Description = "Home Manager System Tray";
  #       Requires = ["graphical-session-pre.target"];
  #     };
  #   };
}
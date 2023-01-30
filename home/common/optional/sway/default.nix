{hostname, ...}: {
  imports = [
    ./kanshi.nix
    ./mako.nix
    ./packages.nix
    ./rofi
    ./swappy.nix
    ./swaylock.nix
    ./waybar.nix
  ];

  wayland.windowManager.sway = let
    modifier = "Mod4";
    terminal = "alacritty";
    menu = "rofi -show drun";
  in {
    enable = true;
    wrapperFeatures.gtk = true;
    systemdIntegration = true;

    config = {
      menu = menu;
      terminal = terminal;
      modifier = modifier;
      bars = [{command = "waybar";}];
      gaps = {inner = 8;};

      input = {
        "*" = {xkb_layout = "gb";};
        "type:touchpad" = {tap = "enabled";};
      };

      output."*".bg = "~/pictures/wallpaper.jpg fill";

      fonts = {
        names = ["Liga SFMono Nerd Font"];
        size = 8.0;
      };

      window = {
        border = 0;
        hideEdgeBorders = "none";
        titlebar = false;
        commands = (import ./config/window-rules.nix {}).commands;
      };

      floating = {
        border = 1;
        titlebar = false;
      };

      focus = {
        newWindow = "focus";
        followMouse = "no";
      };

      startup = [
        {command = "avizo-service";}
        {command = "dbus-update-activation-environment --systemd WAYLAND_DISPLAY DISPLAY SWAYSOCK";}
        {command = "mako";}
        {command = "wl-paste -n -t text --watch clipman store --no-persist";}
        {command = "wl-paste -p -n -t text --watch clipman store -P";}
        {command = "wlsunset -l 51.51 -L -2.53";}
        {command = "lockscreen";}
      ];

      keybindings = (import ./config/keybindings.nix {inherit terminal menu modifier;}).main;
      modes.resize = (import ./config/keybindings.nix {inherit terminal menu modifier;}).resize;
      workspaceOutputAssign = (import ./config/displays.nix {}).${hostname}.workspace-assignments;
      assigns = (import ./config/window-rules.nix {}).assigns;
    };
  };

  home.sessionVariables = {
    _JAVA_AWT_WM_NONREPARENTING = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
    GDK_BACKEND = "wayland";
  };
}

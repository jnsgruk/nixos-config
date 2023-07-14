{ hostname, pkgs, theme, ... }: {
  imports = [
    ../rofi
    ../waybar

    ../mako.nix
    ../swappy.nix
    ../swaylock.nix
    ../wl-common.nix

    ./kanshi.nix
    ./packages.nix
  ];

  wayland.windowManager.sway =
    let
      modifier = "Mod4";
      terminal = "alacritty";
      menu = "rofi -show drun";
    in
    {
      enable = true;

      systemdIntegration = true;
      wrapperFeatures = {
        gtk = true;
        base = true;
      };

      config = {
        inherit menu terminal modifier;
        bars = [ ];
        gaps = { inner = 8; };

        input = {
          "*" = { xkb_layout = "gb"; };
          "type:touchpad" = { tap = "enabled"; };
        };

        output."*".bg = "${theme.wallpaper} fill";

        fonts = {
          names = [ "${theme.fonts.iconFont.name}" ];
          size = 8.0;
        };

        window = {
          border = 0;
          hideEdgeBorders = "none";
          titlebar = false;
          inherit ((import ./config/window-rules.nix { })) commands;
        };

        floating = {
          border = 1;
          titlebar = false;
        };

        focus = {
          newWindow = "focus";
          followMouse = "no";
        };

        startup = [ ];

        keybindings = (import ./config/keybindings.nix { inherit terminal menu modifier pkgs; }).main;
        modes.resize = (import ./config/keybindings.nix { inherit terminal menu modifier pkgs; }).resize;
        workspaceOutputAssign = (import ./config/displays.nix { }).${hostname}.workspace-assignments;
        inherit ((import ./config/window-rules.nix { })) assigns;
      };
    };

  home.sessionVariables = {
    _JAVA_AWT_WM_NONREPARENTING = "1";
    CLUTTER_BACKEND = "wayland";
    GDK_BACKEND = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    # QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
  };
}

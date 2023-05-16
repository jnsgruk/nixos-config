{ hostname, inputs, lib, pkgs, ... }:
let
  outputs =
    if hostname == "freyja"
    then ''
      monitor=eDP-1, preferred, auto, 1.5
    ''
    else if hostname == "loki"
    then ''
      monitor=HDMI-A-1, preferred, 3840x0, 1
      monitor=HDMI-A-2, preferred, 0x0, 1
    ''
    else "";
in
{
  imports = [
    inputs.hyprland.homeManagerModules.default

    ../rofi
    ../waybar

    ../mako.nix
    ../swappy.nix
    ../swaylock.nix
    ../wl-common.nix

    ./packages.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland-hidpi;
    systemdIntegration = true;
    recommendedEnvironment = true;

    xwayland = {
      enable = true;
      hidpi = true;
    };

    extraConfig = ''
      $mod = SUPER
        
      ${outputs}
      
      # automatically place non-specified monitors to the right with auto res/scale
      monitor=,preferred,auto,1

      exec-once = waybar
      exec-once = ${pkgs.dbus}/bin/dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE NIXOS_OZONE_WL
      exec-once = systemctl --user import-environment DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE NIXOS_OZONE_WL
      exec-once = systemctl --user start hyprland-session.target

      gestures {
        workspace_swipe = true
        workspace_swipe_forever = true
      }

      input {
        kb_layout = gb
        follow_mouse = 1
      }

      general {
        gaps_in = 4
        gaps_out = 8
        border_size = 0
      }

      dwindle {
        preserve_split = true
      }

      decoration {
        rounding = 5
        blur = true
        blur_size = 3
        blur_passes = 3
        blur_new_optimizations = true

        drop_shadow = true
        shadow_ignore_window = true
        shadow_offset = 0 5
        shadow_range = 50
        shadow_render_power = 3
        col.shadow = rgba(00000099)
      }

      animations {
        enabled = true
        animation = border, 1, 2, default
        animation = fade, 1, 4, default
        animation = windows, 1, 3, default, popin 80%
        animation = workspaces, 1, 2, default, slide
      }

      # only allow shadows for floating windows
      windowrulev2 = noshadow, floating:0

      # idle inhibit while watching videos
      windowrulev2 = idleinhibit focus, class:^(mpv|.+exe)$
      windowrulev2 = idleinhibit focus, class:^(firefox)$, title:^(.*YouTube.*)$
      windowrulev2 = idleinhibit fullscreen, class:^(firefox)$

      # make Firefox PiP window floating and sticky
      windowrulev2 = float, title:^(Picture-in-Picture)$
      windowrulev2 = pin, title:^(Picture-in-Picture)$

      windowrulev2 = float, class:^(1Password)$
      windowrulev2 = nomaxsize, class:^(1Password)$
        
      # throw sharing indicators away
      windowrulev2 = workspace special silent, title:^(Firefox — Sharing Indicator)$
      windowrulev2 = workspace special silent, title:^(.*is sharing (your screen|a window)\.)$

      # pin to workspaces
      windowrulev2 = workspace 1 silent, class:[Ff]irefox
      windowrulev2 = workspace 2 silent, class:[Oo]bsidian
      windowrulev2 = workspace 2 silent, class:google-chrome
      windowrulev2 = workspace 3 silent, class:[Rr]ambox
      windowrulev2 = workspace 4 silent, class:[Ss]ignal
      windowrulev2 = workspace 5 silent, class:code-url-handler

      bind = $mod, RETURN, exec, ${lib.getExe pkgs.alacritty}
      bind = ALT, Q, killactive,
      bind = $mod SHIFT, E, exec, rofi-power-menu hyprland
      bind = $mod, L, exec, ${lib.getExe pkgs.swaylock-effects} -f
      bind = $mod, SPACE, exec, rofi -show drun

      bind = $mod SHIFT, F, fullscreen,
      bind = $mod SHIFT, Space, togglefloating,
      bind = $mod, A, togglesplit,
        
      # group management
      bind = $mod, G, togglegroup,
      bind = $mod SHIFT, G, moveoutofgroup,
      bind = ALT, left, changegroupactive, b
      bind = ALT, right, changegroupactive, f
      bind = ALT SHIFT, left, moveintogroup, l
      bind = ALT SHIFT, right, moveintogroup, r
      bind = ALT SHIFT, up, moveintogroup, u
      bind = ALT SHIFT, down, moveintogroup, d

      # move focus
      bind = $mod, left, movefocus, l
      bind = $mod, right, movefocus, r
      bind = $mod, up, movefocus, u
      bind = $mod, down, movefocus, d

      # move window
      bind = $mod SHIFT, left, movewindow, l
      bind = $mod SHIFT, right, movewindow, r
      bind = $mod SHIFT, up, movewindow, u
      bind = $mod SHIFT, down, movewindow, d

      # window resize
      bind = $mod, R, submap, resize
      submap = resize
      binde = , right, resizeactive, 10 0
      binde = , left, resizeactive, -10 0
      binde = , up, resizeactive, 0 -10
      binde = , down, resizeactive, 0 10
      bind = , escape, submap, reset
      submap = reset

      # Screenshots
      bind = , Print, exec, ${lib.getExe pkgs.grimblast} save output - | ${lib.getExe pkgs.swappy} -f -
      bind = SHIFT, Print, exec, ${lib.getExe pkgs.grimblast} save active - | ${lib.getExe pkgs.swappy} -f -
        
      $screenshotarea = hyprctl keyword animation "fadeOut,0,0,default"; ${lib.getExe pkgs.grimblast} save area - | ${lib.getExe pkgs.swappy} -f -; hyprctl keyword animation "fadeOut,1,4,default"
      bind = ALT, Print, exec, $screenshotarea

      # media controls
      bindl = , XF86AudioPlay, exec, ${lib.getExe pkgs.playerctl} play-pause
      bindl = , XF86AudioPrev, exec, ${lib.getExe pkgs.playerctl} previous
      bindl = , XF86AudioNext, exec, ${lib.getExe pkgs.playerctl} next

      # volume
      bindle = , XF86AudioRaiseVolume, exec, ${pkgs.avizo}/bin/volumectl -u up
      bindle = , XF86AudioLowerVolume, exec, ${pkgs.avizo}/bin/volumectl -u down
      bindl = , XF86AudioMute, exec, ${pkgs.avizo}/bin/volumectl -u toggle-mute
      bindl = , XF86AudioMicMute, exec, ${pkgs.avizo}/bin/volumectl -m toggle-mute
      bind = , Pause, exec, ${pkgs.avizo}/bin/volumectl -m toggle-mute
        
      # backlight
      bindle = , XF86MonBrightnessUp, exec, ${pkgs.avizo}/bin/lightctl up
      bindle = , XF86MonBrightnessDown, exec, ${pkgs.avizo}/bin/lightctl down

      # apps
      bind = $mod, grave, exec, ${lib.getExe pkgs._1password-gui} --quick-access
      bind = $mod, C, exec, ${lib.getExe pkgs.clipman} pick -t rofi -T='-p Clipboard'

      # binds mod + [shift +] {1..10} to [move to] ws {1..10}
      ${builtins.concatStringsSep "\n" (builtins.genList (
          x: let
            ws = let
              c = (x + 1) / 10;
            in
              builtins.toString (x + 1 - (c * 10));
          in ''
            bind = $mod, ${ws}, workspace, ${toString (x + 1)}
            bind = $mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}
          ''
        )
        10)}

      # Moust bindings
      bindm = SUPER, mouse:272, movewindow
      bindm = SUPER, mouse:273, resizewindow
    '';
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

  systemd.user.services.swaybg = {
    Unit.Description = "swaybg";
    Install.WantedBy = [ "graphical-session.target" ];
    Service = {
      Type = "simple";
      ExecStart = "${lib.getExe pkgs.swaybg} -m fill -i ${../wallpapers/elk-colors.jpg}";
      Restart = "on-failure";
    };
  };
}

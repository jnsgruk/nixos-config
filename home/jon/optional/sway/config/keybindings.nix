{
  modifier,
  terminal,
  menu,
  ...
}: {
  main = {
    # Open a terminal
    "${modifier}+Return" = "exec ${terminal}";
    # Toggle the launcher
    "${modifier}+Space" = "exec ${menu} | xargs swaymsg exec --";
    # Reload the config
    "${modifier}+Shift+c" = "reload";
    # Lock the screen
    "${modifier}+l" = "exec swaylock -f";
    # Exit sway
    "${modifier}+Shift+e" = "exec sway-exit";
    # Kill application
    "Mod1+q" = "kill";

    # Screenshots
    "Print" = "exec sway-screenshot screen";
    "Shift+Print" = "exec sway-screenshot window";
    "Alt+Print" = "exec sway-screenshot region";

    # Move focus
    "${modifier}+Left" = "focus left";
    "${modifier}+Right" = "focus right";
    "${modifier}+Up" = "focus up";
    "${modifier}+Down" = "focus down";

    # Workspaces
    "${modifier}+1" = "workspace number 1";
    "${modifier}+2" = "workspace number 2";
    "${modifier}+3" = "workspace number 3";
    "${modifier}+4" = "workspace number 4";
    "${modifier}+5" = "workspace number 5";
    "${modifier}+6" = "workspace number 6";
    "${modifier}+7" = "workspace number 7";
    "${modifier}+8" = "workspace number 8";
    "${modifier}+9" = "workspace number 9";

    # Move focused container to workspace
    "${modifier}+Shift+1" = "move container to workspace number 1";
    "${modifier}+Shift+2" = "move container to workspace number 2";
    "${modifier}+Shift+3" = "move container to workspace number 3";
    "${modifier}+Shift+4" = "move container to workspace number 4";
    "${modifier}+Shift+5" = "move container to workspace number 5";
    "${modifier}+Shift+6" = "move container to workspace number 6";
    "${modifier}+Shift+7" = "move container to workspace number 7";
    "${modifier}+Shift+8" = "move container to workspace number 8";
    "${modifier}+Shift+9" = "move container to workspace number 9";

    # Split current object of focus
    "${modifier}+h" = "splith";
    "${modifier}+v" = "splitv";

    # Switch layout style for current container
    "${modifier}+s" = "layout stacking";
    "${modifier}+w" = "layout tabbed";
    "${modifier}+e" = "layout toggle split";

    # Make current container fullscreen
    "${modifier}+f" = "fullscreen";
    # Toggle current container between tiling/floating
    "${modifier}+Shift+space" = "floating toggle";
    # Swap focus between tiled windows and floating window
    "Mod1+space" = "focus mode_toggle";
    # Focus parent container
    "${modifier}+a" = "focus parent";
    # Move focused window to scratch pad
    "${modifier}+Shift+minus" = "move scratchpad";
    "${modifier}+minus" = "scratchpad show";

    "${modifier}+r" = "mode 'resize'";

    # Audio/Media Keys
    "--locked XF86AudioPlay" = "exec playerctl play-pause";
    "--locked XF86AudioNext" = "exec playerctl next";
    "--locked XF86AudioPrev" = "exec playerctl prev";

    # Volume Keys
    "--locked XF86AudioRaiseVolume" = "exec volumectl -u up";
    "--locked XF86AudioLowerVolume" = "exec volumectl -u down";
    "--locked XF86AudioMute" = "exec volumectl toggle-mute";
    "--locked Pause" = "exec volumectl -m toggle-mute";

    # Brightness Controls
    "--locked XF86MonBrightnessUp" = "exec lightctl up";
    "--locked XF86MonBrightnessDown" = "exec lightctl down";

    # Applications
    "Mod1+grave" = "exec 1password --quick-access";
  };

  resize = {
    "Left" = "resize shrink width 10px";
    "Right" = "resize shrink width 10px";
    "Up" = "resize shrink height 10px";
    "Down" = "resize grow height 10px";
    "Return" = "mode 'default'";
    "Escape" = "mode 'default'";
  };
}

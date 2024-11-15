{ pkgs, ... }:
{
  services.aerospace = {
    enable = false;
    package = pkgs.aerospace;
    settings = {
      enable-normalization-opposite-orientation-for-nested-containers = true;
      enable-normalization-flatten-containers = true;
      on-focused-monitor-changed = [ "move-mouse monitor-lazy-center" ];
      key-mapping.preset = "qwerty";

      gaps = {
        outer.top = 8;
        outer.right = 8;
        outer.bottom = 8;
        outer.left = 8;
        inner.horizontal = 8;
        inner.vertical = 8;
      };

      mode.main.binding = {
        alt-enter = "exec-and-forget open -n '/Applications/Nix Apps/Alacritty.app'";
        alt-backtick = "exec-and-forget /Applications/1Password.app/Contents/MacOS/1Password --quick-access";
        alt-f = "fullscreen";

        alt-1 = "workspace 1";
        alt-2 = "workspace 2";
        alt-3 = "workspace 3";
        alt-4 = "workspace 4";
        alt-5 = "workspace 5";
        alt-6 = "workspace 6";
        alt-7 = "workspace 7";
        alt-8 = "workspace 8";
        alt-9 = "workspace 9";

        alt-shift-1 = "move-node-to-workspace 1";
        alt-shift-2 = "move-node-to-workspace 2";
        alt-shift-3 = "move-node-to-workspace 3";
        alt-shift-4 = "move-node-to-workspace 4";
        alt-shift-5 = "move-node-to-workspace 5";
        alt-shift-6 = "move-node-to-workspace 6";
        alt-shift-7 = "move-node-to-workspace 7";
        alt-shift-8 = "move-node-to-workspace 8";
        alt-shift-9 = "move-node-to-workspace 9";

        # See: https://nikitabobko.github.io/AeroSpace/commands#layout
        alt-a = "layout tiles horizontal vertical";
        alt-comma = "layout accordion horizontal vertical";
        alt-shift-space = "layout floating tiling";

        # alt-h = "split horizontal";
        # alt-v = "split vertical";

        # See: https://nikitabobko.github.io/AeroSpace/commands#focus
        alt-left = "focus left";
        alt-down = "focus down";
        alt-up = "focus up";
        alt-right = "focus right";

        # See: https://nikitabobko.github.io/AeroSpace/commands#move
        alt-shift-left = "move left";
        alt-shift-down = "move down";
        alt-shift-up = "move up";
        alt-shift-right = "move right";

        # See: https://nikitabobko.github.io/AeroSpace/commands#resize
        alt-shift-minus = "resize smart -50";
        alt-shift-equal = "resize smart +50";

        # See: https://nikitabobko.github.io/AeroSpace/commands#workspace-back-and-forth
        alt-tab = "workspace-back-and-forth";

        alt-r = "mode resize";
        alt-shift-semicolon = "mode service";
      };

      mode.resize.binding = {
        # Resize the window
        left = "resize width -50";
        up = "resize height +50";
        down = "resize height -50";
        right = "resize width +50";
        enter = "mode main";
        esc = "mode main";
      };

      mode.service.binding = {
        esc = "mode main";
        r = [
          "flatten-workspace-tree"
          "mode main"
        ];
        f = [
          "layout floating tiling"
          "mode main"
        ];

        left = [
          "join-with left"
          "mode main"
        ];
        right = [
          "join-with right"
          "mode main"
        ];
        up = [
          "join-with up"
          "mode main"
        ];
        down = [
          "join-with down"
          "mode main"
        ];
      };

      on-window-detected = [ ];
    };
  };
}

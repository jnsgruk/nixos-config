{
  pkgs,
  self,
  hostname,
  ...
}:
{
  imports = [
    ../waybar

    ../mako.nix
    ../rofi.nix
    ../swappy.nix
    ./swaylock.nix
    ../wl-common.nix

    ./packages.nix
  ];

  wayland.windowManager.sway =
    let
      theme = import "${self}/lib/theme" { inherit pkgs hostname; };
      modifier = "Mod4";
      terminal = "alacritty";
      menu = "rofi -show drun";
    in
    {
      enable = true;

      systemd.enable = true;
      wrapperFeatures = {
        gtk = true;
        base = true;
      };

      config = {
        inherit menu terminal modifier;
        bars = [ ];
        gaps = {
          inner = 8;
        };

        input = {
          "*" = {
            xkb_layout = "gb";
          };
          "type:keyboard" = {
            repeat_rate = "100";
            repeat_delay = "250";
          };
          "type:touchpad" = {
            tap = "enabled";
          };
        };

        output = (import ./config/displays.nix { inherit (theme) wallpaper; })."${hostname}";

        fonts = {
          names = [ "${theme.fonts.iconFont.name}" ];
          size = 8.0;
        };

        window = {
          border = 0;
          hideEdgeBorders = "none";
          titlebar = false;
          inherit ((import ./config/window-rules.nix { inherit theme; })) commands;
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

        keybindings =
          (import ./config/keybindings.nix {
            inherit
              terminal
              menu
              modifier
              pkgs
              ;
          }).main;
        modes.resize =
          (import ./config/keybindings.nix {
            inherit
              terminal
              menu
              modifier
              pkgs
              ;
          }).resize;
      };
    };
}

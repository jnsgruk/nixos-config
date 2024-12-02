{
  self,
  hostname,
  lib,
  pkgs,
  ...
}:
let
  theme = import "${self}/lib/theme" { inherit pkgs hostname; };
  inherit (theme) colours fonts;
  keybinds = builtins.readFile ./config/keybinds.conf;
  outputs = (import ./config/displays.nix { }).${hostname};
  windowRules = import ./config/window-rules.nix { };
in
{
  imports = [
    ../wl-common.nix
    ./hyprlock.nix
    ./hyprshot.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    settings = {
      inherit (outputs) monitor workspace;
      inherit (windowRules) windowrulev2;

      "$mod" = "SUPER";

      general = {
        gaps_in = 4;
        gaps_out = 8;
        border_size = 0;
      };

      dwindle = {
        preserve_split = true;
        force_split = 2;
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_forever = true;
        workspace_swipe_invert = false;
      };

      input = {
        kb_layout = "gb";
        follow_mouse = 2;
        repeat_rate = 50;
        repeat_delay = 300;
      };

      decoration = {
        rounding = 8;
        shadow = {
          enabled = true;
          ignore_window = true;
          offset = "0 5";
          range = 50;
          render_power = 3;
          color = "rgba(00000099)";
        };
      };

      animation = [
        "border, 1, 2, default"
        "fade, 1, 4, default"
        "windows, 1, 3, default, popin 80%"
        "workspaces, 1, 2, default, slide"
      ];

      misc = {
        background_color = "rgb(${__substring 1 7 colours.surface1})";
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        animate_manual_resizes = true;
      };

      group = {
        groupbar = {
          font_family = "${fonts.default.name}";
          font_size = 12;
          gradients = true;
        };
      };

      xwayland = {
        force_zero_scaling = true;
      };
    };

    extraConfig = ''
      ${keybinds}
    '';
  };

  systemd.user.services.swaybg = {
    Unit.Description = "swaybg";
    Install.WantedBy = [ "hyprland-session.target" ];
    Service = {
      Type = "simple";
      ExecStart = "${lib.getExe pkgs.swaybg} -m fill -i ${theme.wallpaper}";
      Restart = "on-failure";
    };
  };
}

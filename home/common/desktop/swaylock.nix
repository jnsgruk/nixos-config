{ lib, pkgs, desktop, theme, ... }:
let
  defaults = theme { inherit pkgs; };
  colours = defaults.colours;
in
{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;

    settings = {

      font = "${defaults.fonts.default.name}";
      clock = true;

      indicator = true;
      ignore-empty-password = true;
      indicator-idle-visible = true;
      disable-caps-lock-text = true;

      timestr = "%R";
      datestr = "%a, %e of %B";
      image = "${defaults.wallpaper}";
      # effect-blur = "30x3";

      key-hl-color = "${colours.green}";
      separator-color = "${colours.black}00";

      inside-color = "${colours.bg}99";
      inside-clear-color = "${colours.yellow}00";
      inside-caps-lock-color = "${colours.lightBlue}00";
      inside-ver-color = "${colours.overlay0}00";
      inside-wrong-color = "${colours.red}00";

      ring-color = "${colours.bgDark}D9";
      ring-clear-color = "${colours.bgDark}D9";
      ring-caps-lock-color = "${colours.bgDark}D9";
      ring-ver-color = "${colours.bgDark}D9";
      ring-wrong-color = "${colours.bgDark}D9";

      line-color = "${colours.black}00";
      line-clear-color = "${colours.yellow}FF";
      line-caps-lock-color = "${colours.lightBlue}FF";
      line-ver-color = "${colours.overlay0}FF";
      line-wrong-color = "${colours.red}FF";

      text-clear-color = "${colours.yellow}00";
      text-ver-color = "${colours.overlay0}00";
      text-wrong-color = "${colours.red}00";

      bs-hl-color = "${colours.red}FF";
      caps-lock-key-hl-color = "${colours.yellow}FF";
      caps-lock-bs-hl-color = "${colours.red}FF";
      text-caps-lock-color = "${colours.lightBlue}";
    };
  };

  services.swayidle = {
    enable = true;
    events = [
      { event = "before-sleep"; command = "${lib.getExe pkgs.swaylock-effects} -f"; }
      { event = "lock"; command = "${lib.getExe pkgs.swaylock-effects} -f"; }
    ];
    timeouts = [
      { timeout = 300; command = "${lib.getExe pkgs.swaylock-effects} -f"; }
    ]
    ++ (lib.optional (desktop == "sway") {
      timeout = 305;
      command = ''${pkgs.sway}/bin/swaymsg "output * dpms off"'';
      resumeCommand = ''${pkgs.sway}/bin/swaymsg "output * dpms on"'';
    })
    ++ (lib.optional (desktop == "hyprland") {
      timeout = 305;
      command = ''${pkgs.hyprland}/bin/hyprctl dispatch dpms off'';
      resumeCommand = ''${pkgs.hyprland}/bin/hyprctl dispatch dpms on'';
    });
  };

  # This defaults to "sway-session.target" which breaks under Hyprland
  systemd.user.services.swayidle.Install.WantedBy = lib.mkForce [ "graphical-session.target" ];
}

{
  lib,
  pkgs,
  self,
  hostname,
  ...
}:
let
  theme = import "${self}/lib/theme" { inherit pkgs hostname; };
in
{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;

    settings = {

      font = "${theme.fonts.default.name}";
      clock = true;

      indicator = true;
      ignore-empty-password = true;
      indicator-idle-visible = true;
      disable-caps-lock-text = true;

      timestr = "%R";
      datestr = "%a, %e of %B";
      image = "${theme.wallpaper}";
      # effect-blur = "30x3";

      key-hl-color = "${theme.colours.green}";
      separator-color = "${theme.colours.black}00";

      inside-color = "${theme.colours.bg}99";
      inside-clear-color = "${theme.colours.yellow}00";
      inside-caps-lock-color = "${theme.colours.lightBlue}00";
      inside-ver-color = "${theme.colours.overlay0}00";
      inside-wrong-color = "${theme.colours.red}00";

      ring-color = "${theme.colours.bgDark}D9";
      ring-clear-color = "${theme.colours.bgDark}D9";
      ring-caps-lock-color = "${theme.colours.bgDark}D9";
      ring-ver-color = "${theme.colours.bgDark}D9";
      ring-wrong-color = "${theme.colours.bgDark}D9";

      line-color = "${theme.colours.black}00";
      line-clear-color = "${theme.colours.yellow}FF";
      line-caps-lock-color = "${theme.colours.lightBlue}FF";
      line-ver-color = "${theme.colours.overlay0}FF";
      line-wrong-color = "${theme.colours.red}FF";

      text-clear-color = "${theme.colours.yellow}00";
      text-ver-color = "${theme.colours.overlay0}00";
      text-wrong-color = "${theme.colours.red}00";

      bs-hl-color = "${theme.colours.red}FF";
      caps-lock-key-hl-color = "${theme.colours.yellow}FF";
      caps-lock-bs-hl-color = "${theme.colours.red}FF";
      text-caps-lock-color = "${theme.colours.lightBlue}";
    };
  };

  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = "${lib.getExe pkgs.swaylock-effects} -f";
      }
      {
        event = "lock";
        command = "${lib.getExe pkgs.swaylock-effects} -f";
      }
    ];
    timeouts = [
      {
        timeout = 300;
        command = "${lib.getExe pkgs.swaylock-effects} -f";
      }
      {
        timeout = 305;
        command = ''${pkgs.sway}/bin/swaymsg "output * dpms off"'';
        resumeCommand = ''${pkgs.sway}/bin/swaymsg "output * dpms on"'';
      }
    ];
  };
}

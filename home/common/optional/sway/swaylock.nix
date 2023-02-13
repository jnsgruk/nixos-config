{ lib, pkgs, ... }: {
  programs.swaylock.settings = {
    font = "SF Pro";
    clock = true;

    indicator = true;
    ignore-empty-password = true;
    indicator-idle-visible = true;
    disable-caps-lock-text = true;

    timestr = "%R";
    datestr = "%a, %e of %B";
    image = "/home/jon/pictures/wallpaper.jpg";
    # effect-blur = "30x3";

    key-hl-color = "880033";
    separator-color = "00000000";

    inside-color = "00000099";
    inside-clear-color = "ffd20400";
    inside-caps-lock-color = "009ddc00";
    inside-ver-color = "d9d8d800";
    inside-wrong-color = "ee2e2400";

    ring-color = "231f20D9";
    ring-clear-color = "231f20D9";
    ring-caps-lock-color = "231f20D9";
    ring-ver-color = "231f20D9";
    ring-wrong-color = "231f20D9";

    line-color = "00000000";
    line-clear-color = "ffd204FF";
    line-caps-lock-color = "009ddcFF";
    line-ver-color = "d9d8d8FF";
    line-wrong-color = "ee2e24FF";

    text-clear-color = "ffd20400";
    text-ver-color = "d9d8d800";
    text-wrong-color = "ee2e2400";

    bs-hl-color = "ee2e24FF";
    caps-lock-key-hl-color = "ffd204FF";
    caps-lock-bs-hl-color = "ee2e24FF";
    text-caps-lock-color = "009ddc";
  };

  services.swayidle = {
    enable = true;
    events = [
      { event = "before-sleep"; command = "${lib.getExe pkgs.swaylock} -f"; }
      { event = "lock"; command = "${lib.getExe pkgs.swaylock} -f"; }
    ];
    timeouts = [
      { timeout = 300; command = "${lib.getExe pkgs.swaylock} -f"; }
      {
        timeout = 305;
        command = ''${pkgs.sway}/bin/swaymsg "output * dpms off"'';
        resumeCommand = ''${pkgs.sway}/bin/swaymsg "output * dpms on"'';
      }
    ];
  };
}

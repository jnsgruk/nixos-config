{ pkgs
, lib
, ...
}:
let
  swayRun = pkgs.writeShellScript "sway-run" ''
    export XDG_SESSION_TYPE=wayland
    export XDG_SESSION_DESKTOP=sway
    export XDG_CURRENT_DESKTOP=sway
    systemd-run \
      --user \
      --scope \
      --collect \
      --quiet \
      --unit=sway \
      systemd-cat \
      --identifier=sway \
      ${pkgs.sway}/bin/sway \
      $@; swaymsg exit
  '';
in
{
  services.greetd = {
    enable = true;
    restart = false;
    settings = {
      default_session = {
        command = "${lib.makeBinPath [pkgs.greetd.tuigreet]}/tuigreet -r --asterisks --time --cmd ${swayRun}";
      };
    };
  };

  environment.etc."greetd/environments".text = ''
    sway
    zsh
  '';
}

{ pkgs, ... }: {
  systemd.user.services.avizo = {
    Unit.Description = "A Wayland notification daemon to be used for multimedia keys";
    Install.WantedBy = [ "sway-session.target" ];
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.avizo}/bin/avizo-service";
      ExecStop = "pkill -2 avizo-service";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
}

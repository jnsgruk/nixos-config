_: {
  kara =
    {
      workspace = [
        "1, monitor: DP-2"
        "2, monitor: DP-2"
        "3, monitor: DP-1"
        "4, monitor: DP-1"
        "5, monitor: DP-2"
        "6, monitor: DP-2"
        "7, monitor: DP-2"
      ];

      monitor = [
        "DP-2, preferred, 3840x0, 1"
        "DP-1, preferred, 0x0, 1"
      ];
    };

  freyja = {
    workspace = [ ];
    monitor = [ "eDP-1, preferred, auto, 1.5" ];
  };
}

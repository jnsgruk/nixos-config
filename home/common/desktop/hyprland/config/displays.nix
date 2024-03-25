_: {
  kara =
    {
      workspace = [
        "1, monitor: HDMI-A-1"
        "2, monitor: HDMI-A-1"
        "3, monitor: HDMI-A-2"
        "4, monitor: HDMI-A-2"
        "5, monitor: HDMI-A-1"
        "6, monitor: HDMI-A-1"
        "7, monitor: HDMI-A-1"
      ];

      monitor = [
        "HDMI-A-1, preferred, 0x0, 1"
        "HDMI-A-2, preferred, 3840x0, 1"
      ];
    };

  freyja = {
    workspace = [ ];
    monitor = [ "eDP-1, preferred, auto, 1.5" ];
  };
}

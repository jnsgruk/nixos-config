{ ... }: {
  loki =
    {
      workspace-assignments = ''
        workspace = 1, monitor: HDMI-A-1
        workspace = 2, monitor: HDMI-A-1
        workspace = 3, monitor: HDMI-A-2
        workspace = 4, monitor: HDMI-A-2
        workspace = 5, monitor: HDMI-A-1
        workspace = 6, monitor: HDMI-A-1
        workspace = 7, monitor: HDMI-A-1
      '';

      outputs = ''
        monitor=HDMI-A-1, preferred, 3840x0, 1
        monitor=HDMI-A-2, preferred, 0x0, 1
      '';
    };

  freyja = {
    workspace-assignments = "";
    outputs = ''
      monitor=eDP-1, preferred, auto, 1.5
    '';
  };
}

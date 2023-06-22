{ ... }: {
  kara = {
    workspace-assignments = [
      {
        workspace = "1";
        output = "HDMI-A-1";
      }
      {
        workspace = "2";
        output = "HDMI-A-1";
      }
      {
        workspace = "5";
        output = "HDMI-A-1";
      }
      {
        workspace = "6";
        output = "HDMI-A-1";
      }
      {
        workspace = "3";
        output = "HDMI-A-2";
      }
      {
        workspace = "4";
        output = "HDMI-A-2";
      }
    ];

    kanshi-profiles = {
      default = {
        outputs = [
          {
            status = "enable";
            criteria = "HDMI-A-1";
            position = "3840,0";
            mode = "3840x2160@60.000Hz";
          }
          {
            status = "enable";
            criteria = "HDMI-A-2";
            position = "0,0";
            mode = "3840x2160@60.000Hz";
          }
        ];
      };
    };
  };

  freyja = {
    workspace-assignments = [ ];
    kanshi-profiles = rec {
      default = {
        outputs = [{
          status = "enable";
          criteria = "eDP-1";
          position = "0,0";
          scale = 1.5;
          mode = "2880x1800@60.001Hz";
        }];
      };
    };
  };
}

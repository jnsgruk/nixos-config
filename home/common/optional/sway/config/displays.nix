{...}: {
  loki = {
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
      default = {};
    };
  };

  odin = {
    workspace-assignments = [];
    kanshi-profiles = rec {
      default = {
        outputs = [
          {
            status = "enable";
            criteria = "eDP-1";
            position = "0,0";
            scale = 2.0;
            mode = "3840x2160@60.02Hz";
          }
        ];
      };

      external-display-1080 = {
        outputs =
          default.outputs
          ++ [
            {
              status = "enable";
              criteria = "eDP-2";
              position = "0,1080";
            }
          ];
      };

      external-display-4k = {
        outputs =
          default.outputs
          ++ [
            {
              status = "enable";
              criteria = "eDP-2";
              position = "-960,-2160";
            }
          ];
      };
    };
  };
}

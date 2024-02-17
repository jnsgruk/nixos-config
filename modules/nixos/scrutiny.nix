{ config, lib, pkgs, ... }:
let
  cfg = config.services.scrutiny;
  collectorCfg = config.services.scrutiny.collector;

  mkScrutinyCfg = cfg: pkgs.writeTextFile {
    name = "scrutiny.yaml";
    text = ''
      version: 1
      web:
        listen:
          port: ${builtins.toString cfg.port}
          host: "${cfg.host}"
          basepath: "${if cfg.basepath != "" then "/" + cfg.basepath else ""}"

        database:
            location: "/var/lib/scrutiny/scrutiny.db"

        src:
            frontend:
                path: "${pkgs.scrutiny}/share/scrutiny"
  
      log:
        level: "${cfg.logLevel}"
    '';
  };
in
{
  options = {
    services.scrutiny = {
      enable = lib.mkEnableOption "Enables the scrutiny web application";

      package = lib.mkPackageOptionMD pkgs "scrutiny" { };

      port = lib.mkOption {
        type = lib.types.port;
        default = 8080;
        description = lib.mdDoc "Port for web application to listen on";
      };

      host = lib.mkOption {
        type = lib.types.str;
        default = "0.0.0.0";
        description = lib.mdDoc "Interface address for web application to bind to";
      };

      basepath = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = lib.mdDoc ''
          If Scrutiny will be behind a path prefixed reverse proxy, you can override this 
          value to serve Scrutiny on a subpath.

          Do not include the leading '/'.
        '';
      };

      openFirewall = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Open the default ports in the firewall for Scrutiny.";
      };

      logLevel = lib.mkOption {
        type = lib.types.enum [ "INFO" "DEBUG" ];
        default = "INFO";
        description = lib.mdDoc "Log level for Scrutiny.";
      };

      collector = {
        enable = lib.mkOption {
          type = lib.types.bool;
          default = cfg.enable;
          description = lib.mdDoc "Enables the scrutiny collector";
        };

        package = lib.mkPackageOptionMD pkgs "scrutiny-collector" { };

        endpoint = lib.mkOption {
          type = lib.types.str;
          default = "http://localhost:${builtins.toString cfg.port}/${cfg.basepath}";
          description = lib.mdDoc "Scrutiny app API endpoint for sending metrics to.";
        };

        interval = lib.mkOption {
          type = lib.types.str;
          default = "15m";
          description = lib.mdDoc ''
            Interval on which to collect information about disks.

            Examples: 15m, 10s, 2h.
          '';
        };
      };
    };
  };

  config = {
    services.influxdb2 = lib.mkIf cfg.enable {
      enable = cfg.enable;
    };

    networking.firewall = lib.mkIf cfg.openFirewall {
      allowedTCPPorts = [ cfg.port ];
    };

    services.smartd = {
      enable = collectorCfg.enable;
      extraOptions = [
        "-A /var/log/smartd/"
        "--interval=600"
      ];
    };

    systemd = {
      services = {
        scrutiny = lib.mkIf cfg.enable {
          description = "Hard Drive S.M.A.R.T Monitoring, Historical Trends & Real World Failure Thresholds";
          wantedBy = [ "multi-user.target" ];
          after = [ "network.target" ];
          serviceConfig = {
            DynamicUser = true;
            ExecStart = "${cfg.package}/bin/scrutiny-web start --config ${mkScrutinyCfg cfg}";
            Restart = "always";
            StateDirectory = "scrutiny";
            StateDirectoryMode = "0750";
          };
        };

        scrutiny-collector = lib.mkIf collectorCfg.enable {
          description = "Scrutiny Collector Service";
          environment = {
            COLLECTOR_API_ENDPOINT = "${collectorCfg.endpoint}";
          };
          serviceConfig = {
            Type = "oneshot";
            ExecStart = "${cfg.collector.package}/bin/scrutiny-collector-metrics run";
          };
        };
      };

      timers = {
        scrutiny-collector = lib.mkIf collectorCfg.enable {
          timerConfig = {
            OnBootSec = "5m";
            OnUnitActiveSec = "${collectorCfg.interval}";
            Unit = "scrutiny-collector.service";
          };
        };
      };
    };
  };
}

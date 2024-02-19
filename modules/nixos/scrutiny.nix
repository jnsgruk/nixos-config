{ config, lib, pkgs, ... }:
let
  cfg = config.services.scrutiny;
  collectorCfg = config.services.scrutiny.collector;

  # Helper function for inserting null values in place of empty strings in conf file.
  optionalStr = e: if e != "" then e else null;

  # Function for constructing a Scrutiny config file from a given Nix configuration.
  mkScrutinyCfg = cfg: pkgs.writeTextFile {
    name = "scrutiny.yaml";
    text = builtins.toJSON {
      version = 1;
      web = {
        listen = {
          inherit (cfg) host port;
          basepath = if cfg.basepath != "" then "/" + cfg.basepath else "";
        };

        database = {
          location = "/var/lib/scrutiny/scrutiny.db";
        };

        src = {
          frontend.path = "${pkgs.scrutiny}/share/scrutiny";
        };

        influxdb = {
          inherit (cfg.influxdb) scheme host port;
          tls.insecure_skip_verify = cfg.influxdb.tlsSkipVerify;
          token = optionalStr cfg.influxdb.token;
          org = optionalStr cfg.influxdb.org;
          bucket = optionalStr cfg.influxdb.bucket;
        };
      };
      log = {
        level = cfg.logLevel;
      };
    };
  };
in
{
  options = {
    services.scrutiny = {
      enable = lib.mkEnableOption "Enables the scrutiny web application.";

      package = lib.mkPackageOptionMD pkgs "scrutiny" { };

      port = lib.mkOption {
        type = lib.types.port;
        default = 8080;
        description = lib.mdDoc "Port for web application to listen on.";
      };

      host = lib.mkOption {
        type = lib.types.str;
        default = "0.0.0.0";
        description = lib.mdDoc "Interface address for web application to bind to.";
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

      influxdb = {
        enable = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = lib.mdDoc ''
            Enables InfluxDB on the host system using the `services.influxdb2` NixOS module
            with default options.

            If you already have InfluxDB configured, or wish to connect to an external InfluxDB
            instance, disable this option.
          '';
        };

        scheme = lib.mkOption {
          type = lib.types.str;
          default = "http";
          description = lib.mdDoc "URL scheme to use when connecting to InfluxDB.";
        };

        host = lib.mkOption {
          type = lib.types.str;
          default = "0.0.0.0";
          description = lib.mdDoc "IP or hostname of the InfluxDB instance.";
        };

        port = lib.mkOption {
          type = lib.types.port;
          default = 8086;
          description = lib.mdDoc "The port of the InfluxDB instance.";
        };

        tlsSkipVerify = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = lib.mdDoc "Skip TLS verification when connecting to InfluxDB.";
        };

        token = lib.mkOption {
          type = lib.types.str;
          default = "";
          description = lib.mdDoc "Authentication token for connecting to InfluxDB.";
        };

        org = lib.mkOption {
          type = lib.types.str;
          default = "";
          description = lib.mdDoc "InfluxDB organisation under which to store data.";
        };

        bucket = lib.mkOption {
          type = lib.types.str;
          default = "";
          description = lib.mdDoc "InfluxDB bucket in which to store data.";
        };
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
          description = lib.mdDoc "Enables the scrutiny collector.";
        };

        package = lib.mkPackageOptionMD pkgs "scrutiny-collector" { };

        endpoint = lib.mkOption {
          type = lib.types.str;
          default = "http://${cfg.host}:${builtins.toString cfg.port}/${cfg.basepath}";
          description = lib.mdDoc "Scrutiny app API endpoint for sending metrics to.";
        };

        interval = lib.mkOption {
          type = lib.types.int;
          default = 15;
          description = lib.mdDoc "Interval (in minutes) on which to collect information about disks.";
        };
      };
    };
  };

  config = {
    services.influxdb2 = lib.mkIf cfg.influxdb.enable {
      inherit (cfg) enable;
    };

    networking.firewall = lib.mkIf cfg.openFirewall {
      allowedTCPPorts = [ cfg.port ];
    };

    services.smartd = lib.mkIf collectorCfg.enable {
      enable = true;
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
            ExecStart = "${lib.getExe cfg.package} start --config ${mkScrutinyCfg cfg}";
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
            ExecStart = "${lib.getExe cfg.collector.package} run";
          };
        };
      };

      timers = lib.mkIf collectorCfg.enable {
        scrutiny-collector = {
          timerConfig = {
            OnBootSec = "1m";
            OnUnitActiveSec = "${builtins.toString collectorCfg.interval}m";
            Unit = "scrutiny-collector.service";
          };
        };
      };
    };
  };
}

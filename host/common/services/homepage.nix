{ pkgs, lib, ... }: {
  networking.firewall = {
    allowedTCPPorts = [ 8082 ];
  };

  systemd.services.homepage = {
    enable = true;
    description = "A highly customizable homepage (or startpage / application dashboard) with Docker and service API integrations.";
    environment = {
      HOMEPAGE_CONFIG_DIR = "/var/lib/homepage";
      PORT = "8082";
    };
    serviceConfig = {
      Type = "simple";
      DynamicUser = true;
      StateDirectory = "homepage";
      ExecStart = "${pkgs.homepage}/bin/homepage";
      Restart = "on-failure";
    };
    wantedBy = [ "multi-user.target" ];
  };
}

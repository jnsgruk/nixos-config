{ pkgs, config, ... }: {
  # Set up for https://www.files.gallery
  services = {
    nginx = {
      enable = true;
      group = "users";
      defaultHTTPListenPort = 8081;
      virtualHosts."_" = {
        root = "/data/apps/files";
        locations."/".extraConfig = ''
          fastcgi_pass  unix:${config.services.phpfpm.pools.nginx-pool.socket};
          fastcgi_index index.php;
          fastcgi_split_path_info ^(.+\.php)(/.+)$;
          include ${pkgs.nginx}/conf/fastcgi_params;
          include ${pkgs.nginx}/conf/fastcgi.conf;
        '';
      };
    };
    phpfpm.pools.nginx-pool = {
      inherit (config.services.nginx) user;
      group = "users";
      settings = {
        pm = "dynamic";
        "listen.owner" = config.services.nginx.user;
        "pm.max_children" = 5;
        "pm.start_servers" = 2;
        "pm.min_spare_servers" = 1;
        "pm.max_spare_servers" = 3;
        "pm.max_requests" = 500;
      };
    };
  };

  environment.systemPackages = with pkgs; [ ffmpeg ];
}

{ pkgs, ... }: {
  services = {
    prowlarr = {
      enable = true;
      openFirewall = true;
    };
    radarr = {
      enable = true;
      package = pkgs.unstable.radarr;
      openFirewall = true;
      group = "users";
    };
    sabnzbd = {
      enable = true;
      package = pkgs.unstable.sabnzbd;
      group = "users";
    };
    sonarr = {
      enable = true;
      package = pkgs.unstable.sonarr;
      openFirewall = true;
      group = "users";
    };
  };
}

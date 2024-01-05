{ pkgs, ... }: {
  services = {
    jellyfin = {
      enable = true;
      package = pkgs.unstable.jellyfin;
      group = "users";
      openFirewall = true;
    };
    prowlarr = {
      enable = true;
      package = pkgs.unstable.prowlarr;
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

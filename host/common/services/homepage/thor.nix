{ config, self, ... }:
{
  age.secrets = {
    dashboard-env = {
      file = "${self}/secrets/thor-dashboard-env.age";
      owner = "root";
      group = "users";
      mode = "400";
    };
  };

  services.homepage-dashboard = {
    environmentFile = config.age.secrets.dashboard-env.path;
    bookmarks = [
      {
        dev = [
          {
            github = [
              {
                abbr = "GH";
                href = "https://github.com/";
                icon = "github-light.png";
              }
            ];
          }
          {
            "homepage docs" = [
              {
                abbr = "HD";
                href = "https://gethomepage.dev";
                icon = "homepage.png";
              }
            ];
          }
        ];
        machines = [
          {
            tower = [
              {
                abbr = "TR";
                href = "https://dash.crgrd.uk";
                icon = "homarr.png";
              }
            ];
          }
          {
            gbox = [
              {
                abbr = "GB";
                href = "https://dash.gbox.crgrd.uk";
                icon = "homepage.png";
              }
            ];
          }
        ];
      }
    ];
    services = [
      {
        media = [
          {
            Jellyfin = {
              icon = "jellyfin.png";
              href = "{{HOMEPAGE_VAR_JELLYFIN_URL}}";
              description = "media management";
              widget = {
                type = "jellyfin";
                url = "{{HOMEPAGE_VAR_JELLYFIN_URL}}";
                key = "{{HOMEPAGE_VAR_JELLYFIN_API_KEY}}";
              };
            };
          }
          {
            Radarr = {
              icon = "radarr.png";
              href = "{{HOMEPAGE_VAR_RADARR_URL}}";
              description = "film management";
              widget = {
                type = "radarr";
                url = "{{HOMEPAGE_VAR_RADARR_URL}}";
                key = "{{HOMEPAGE_VAR_RADARR_API_KEY}}";
              };
            };
          }
          {
            Sonarr = {
              icon = "sonarr.png";
              href = "{{HOMEPAGE_VAR_SONARR_URL}}";
              description = "tv management";
              widget = {
                type = "sonarr";
                url = "{{HOMEPAGE_VAR_SONARR_URL}}";
                key = "{{HOMEPAGE_VAR_SONARR_API_KEY}}";
              };
            };
          }
          {
            Prowlarr = {
              icon = "prowlarr.png";
              href = "{{HOMEPAGE_VAR_PROWLARR_URL}}";
              description = "index management";
              widget = {
                type = "prowlarr";
                url = "{{HOMEPAGE_VAR_PROWLARR_URL}}";
                key = "{{HOMEPAGE_VAR_PROWLARR_API_KEY}}";
              };
            };
          }
          {
            Sabnzbd = {
              icon = "sabnzbd.png";
              href = "{{HOMEPAGE_VAR_SABNZBD_URL}}/";
              description = "download client";
              widget = {
                type = "sabnzbd";
                url = "{{HOMEPAGE_VAR_SABNZBD_URL}}";
                key = "{{HOMEPAGE_VAR_SABNZBD_API_KEY}}";
              };
            };
          }
        ];
      }
      {
        infra = [
          {
            Files = {
              description = "file manager";
              icon = "files.png";
              href = "https://files.jnsgr.uk";
            };
          }
          {
            "Syncthing (thor)" = {
              description = "syncthing ui for thor";
              icon = "syncthing.png";
              href = "https://thor.sync.jnsgr.uk";
            };
          }
          {
            "Syncthing (kara)" = {
              description = "syncthing ui for kara";
              icon = "syncthing.png";
              href = "https://kara.sync.jnsgr.uk";
            };
          }
          {
            "Syncthing (freyja)" = {
              description = "syncthing ui for freyja";
              icon = "syncthing.png";
              href = "https://freyja.sync.jnsgr.uk";
            };
          }
        ];
      }
    ];
    settings = {
      title = "sgrs dashboard";
      favicon = "https://jnsgr.uk/favicon.ico";
      headerStyle = "clean";
      layout = {
        media = {
          style = "row";
          columns = 3;
        };
        infra = {
          style = "row";
          columns = 4;
        };
        machines = {
          style = "row";
          columns = 4;
        };
      };
    };
    widgets = [
      {
        search = {
          provider = "google";
          target = "_blank";
        };
      }
      {
        resources = {
          label = "system";
          cpu = true;
          memory = true;
        };
      }
      {
        resources = {
          label = "storage";
          disk = [ "/data" ];
        };
      }
      {
        openmeteo = {
          label = "Bristol";
          timezone = "Europe/London";
          latitude = "{{HOMEPAGE_VAR_LATITUDE}}";
          longitude = "{{HOMEPAGE_VAR_LONGITUDE}}";
          units = "metric";
        };
      }
    ];
  };
}

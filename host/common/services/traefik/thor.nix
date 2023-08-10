{ config, ... }:
let
  internalDomain = "tailnet-d5da.ts.net";
  externalDomain = "jnsgr.uk";

  mkLB = address: { loadBalancer = { servers = [{ url = "${address}"; }]; }; };

  mkTsRouter = { name, middlewares ? [ ] }: {
    inherit middlewares;
    rule = "Host(`thor.${internalDomain}`) && Path(`/${name}`) || PathPrefix(`/${name}`)";
    service = name;
    entryPoints = [ "websecure" ];
    tls.certresolver = "tailscale";
  };

  mkExtRouter = { subdomain, middlewares ? [ ] }: {
    inherit middlewares;
    rule = "Host(`${subdomain}.${externalDomain}`)";
    service = subdomain;
    entryPoints = [ "websecure" ];
    tls.certresolver = "letsencrypt";
  };
in
{
  age.secrets.digitalocean = {
    file = ../../../../secrets/digitalocean.age;
    owner = "traefik";
    group = "traefik";
    mode = "600";
  };
  # Set an environment variable that points Traefik to the location of a file
  # that holds a DigitalOcean API key.
  systemd.services.traefik.environment = {
    DO_AUTH_TOKEN_FILE = config.age.secrets.digitalocean.path;
  };

  services = {
    # Enable traefik to talk to the tailscale daemon for certs
    tailscale.permitCertUid = "traefik";

    traefik = {
      staticConfigOptions = {
        certificatesResolvers = {
          letsencrypt.acme = {
            email = "admin@sgrs.uk";
            storage = "${config.services.traefik.dataDir}/acme.json";
            dnsChallenge.provider = "digitalocean";
          };
          tailscale.tailscale = { };
        };
        entryPoints = {
          web = {
            address = ":80";
            http.redirections.entrypoint = {
              scheme = "https";
              to = "websecure";
            };
          };
          websecure.address = ":443";
        };
      };
      dynamicConfigOptions = {
        http = {
          middlewares = {
            sabnzbd-strip-prefix.stripPrefix.prefixes = [ "/sabnzbd" ];
          };

          routers = {
            backup = mkExtRouter { subdomain = "backup"; };
            files = mkExtRouter { subdomain = "files"; };
            dash = mkExtRouter { subdomain = "dash"; };

            freyja-syncthing = mkExtRouter { subdomain = "freyja.sync"; };
            kara-syncthing = mkExtRouter { subdomain = "kara.sync"; };
            thor-syncthing = mkExtRouter { subdomain = "thor.sync"; };

            prowlarr = mkTsRouter { name = "prowlarr"; };
            radarr = mkTsRouter { name = "radarr"; };
            sonarr = mkTsRouter { name = "sonarr"; };

            sabnzbd = mkTsRouter {
              name = "sabnzbd";
              middlewares = [ "sabnzbd-strip-prefix" ];
            };
          };

          services = {
            backup = mkLB "http://localhost:8200";
            files = mkLB "http://localhost:8081";
            dash = mkLB "http://localhost:8082";

            "freyja.sync" = mkLB "http://freyja.${internalDomain}:8384";
            "kara.sync" = mkLB "http://kara.${internalDomain}:8384";
            "thor.sync" = mkLB "http://thor.${internalDomain}:8384";

            prowlarr = mkLB "http://localhost:9696";
            radarr = mkLB "http://localhost:7878";
            sonarr = mkLB "http://localhost:8989";

            sabnzbd = mkLB "http://localhost:8080";
          };
        };
      };
    };
  };
}

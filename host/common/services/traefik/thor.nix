{ config, self, ... }:
let
  internalDomain = "tailnet-d5da.ts.net";
  externalDomain = "jnsgr.uk";

  mkLB = address: {
    loadBalancer = {
      servers = [ { url = "${address}"; } ];
    };
  };

  mkExtRouter =
    {
      subdomain,
      middlewares ? [ ],
    }:
    {
      inherit middlewares;
      rule = "Host(`${subdomain}.${externalDomain}`)";
      service = subdomain;
      entryPoints = [ "websecure" ];
      tls.certresolver = "letsencrypt";
    };
in
{
  age.secrets.digitalocean = {
    file = "${self}/secrets/thor-digitalocean.age";
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
          routers = {
            files = mkExtRouter { subdomain = "files"; };
            dash = mkExtRouter { subdomain = "dash"; };

            freyja-syncthing = mkExtRouter { subdomain = "freyja.sync"; };
            kara-syncthing = mkExtRouter { subdomain = "kara.sync"; };
            thor-syncthing = mkExtRouter { subdomain = "thor.sync"; };
          };

          services = {
            files = mkLB "http://localhost:8081";
            dash = mkLB "http://localhost:8082";

            "freyja.sync" = mkLB "http://freyja.${internalDomain}:8384";
            "kara.sync" = mkLB "http://kara.${internalDomain}:8384";
            "thor.sync" = mkLB "http://thor.${internalDomain}:8384";
          };
        };
      };
    };
  };
}

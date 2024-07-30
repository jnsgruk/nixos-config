{ config, self, ... }:
let
  tailnet = "tailnet-d5da.ts.net";
  domain = "jnsgr.uk";

  mkVHost = backend: ''
    tls {
      dns digitalocean {$DO_AUTH_TOKEN}
    }
    reverse_proxy ${backend}
  '';
in
{
  age.secrets.digitalocean = {
    file = "${self}/secrets/thor-digitalocean.age";
    owner = "caddy";
    group = "caddy";
    mode = "600";
  };

  # Ensure DigitalOcean token is in Caddy's environment
  systemd.services.caddy.serviceConfig.EnvironmentFile = config.age.secrets.digitalocean.path;

  services = {
    # Enable caddy to talk to the tailscale daemon for certs
    tailscale.permitCertUid = "caddy";

    caddy.virtualHosts = {
      "dash.${domain}".extraConfig = mkVHost "http://localhost:8082";
      "files.${domain}".extraConfig = mkVHost "http://localhost:8081";
      "freyja.sync.${domain}".extraConfig = mkVHost "http://freyja.${tailnet}:8384";
      "kara.sync.${domain}".extraConfig = mkVHost "http://kara.${tailnet}:8384";
      "thor.sync.${domain}".extraConfig = mkVHost "http://thor.${tailnet}:8384";
    };
  };
}

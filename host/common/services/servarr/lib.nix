{
  pkgs,
  lib,
  addresses,
  ...
}:
{
  mkAppContainer =
    { name }:
    let
      addressParts = lib.strings.splitString ":" addresses."${name}";
    in
    {
      autoStart = true;
      privateNetwork = true;
      hostAddress = "192.168.100.10";
      localAddress = builtins.elemAt addressParts 0;
      enableTun = true;
      bindMounts = {
        "/data/media" = {
          hostPath = "/data/media";
          isReadOnly = false;
        };
      };
      nixpkgs = pkgs.unstable.path;
      config =
        { config, lib, ... }:
        {
          nixpkgs.config.allowUnfree = true;
          system.stateVersion = "24.05";

          networking = {
            firewall = {
              enable = true;
              trustedInterfaces = [ "tailscale0" ];
            };
            useHostResolvConf = lib.mkForce false;
          };

          services = {
            "${name}" = {
              enable = true;
              openFirewall = true;
            };

            caddy = {
              enable = true;
              virtualHosts."${name}.tailnet-d5da.ts.net".extraConfig = ''
                reverse_proxy http://localhost:${builtins.elemAt addressParts 1}
              '';
            };

            tailscale = {
              enable = true;
              openFirewall = true;
              useRoutingFeatures = "both";
              permitCertUid = "caddy";
            };

            resolved.enable = true;
          };
        };
    };
}

{ pkgs, inputs, ... }:
{
  disabledModules = [ "services/web-apps/immich.nix" ];
  imports = [
    "${inputs.unstable}/nixos/modules/services/web-apps/immich.nix"
  ];

  services.immich = {
    enable = true;
    package = pkgs.unstable.immich;
    openFirewall = true;
    port = 3001;

    redis = {
      enable = true;
      host = "127.0.0.1";
      port = 6379;
    };
  };
}

{ pkgs, inputs, ... }:
{
  # Always use module from master
  disabledModules = [ "services/web-apps/immich.nix" ];
  imports = [
    "${inputs.master}/nixos/modules/services/web-apps/immich.nix"
  ];

  services.immich = {
    enable = true;
    package = pkgs.master.immich;
    openFirewall = true;
    host = "thor.tailnet-d5da.ts.net";
  };
}

{ pkgs, inputs, ... }:
{
  # Always use module from unstable
  disabledModules = [ "services/web-apps/immich.nix" ];
  imports = [
    "${inputs.unstable}/nixos/modules/services/web-apps/immich.nix"
  ];

  services.immich = {
    enable = true;
    package = pkgs.unstable.immich;
  };
}

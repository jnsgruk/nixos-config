{ inputs, pkgs, ... }:
let
  lxdModule = "nixos/modules/virtualisation/lxd.nix";
in
{
  # Always use the lxd module from nixos-unstable
  disabledModules = [ "${inputs.nixpkgs}/${lxdModule}" ];
  imports = [ "${inputs.nixpkgs-unstable}/${lxdModule}" ];

  virtualisation = {
    lxd = {
      enable = true;
      zfsSupport = true;
      ui = {
        enable = true;
        package = pkgs.unstable.lxd.ui;
      };
    };
  };
}

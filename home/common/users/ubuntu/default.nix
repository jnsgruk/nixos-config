{ pkgs, self, ... }:
let
  inherit ((import "${self}/host/common/base/packages.nix" { inherit pkgs; })) basePackages;
in
{
  imports = [ "${self}/home/common/dev/base.nix" ];
  home.packages = basePackages;
}

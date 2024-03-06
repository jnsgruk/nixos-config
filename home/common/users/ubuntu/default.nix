{ pkgs, self, ... }:
let
  inherit ((import "${self}/host/common/base/packages.nix" { inherit pkgs; })) basePackages;
in
{
  imports = [ "${self}/dev/base.nix" ];
  home.packages = basePackages;
}

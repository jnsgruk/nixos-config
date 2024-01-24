{ pkgs, ... }:
let
  inherit ((import ../../../../host/common/base/packages.nix { inherit pkgs; })) basePackages;
in
{
  imports = [ ../../dev/base.nix ];
  home.packages = basePackages;
}

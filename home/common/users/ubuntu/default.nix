{ pkgs, ... }:
let
  basePackages = (import ../../../../host/common/base/packages.nix { inherit pkgs; }).basePackages;
in
{
  imports = [
    ../../dev/cloud.nix
    ../../dev/containers.nix
    ../../dev/go.nix
    ../../dev/python.nix
    ../../dev/shell.nix
  ];

  home.packages = basePackages;
}

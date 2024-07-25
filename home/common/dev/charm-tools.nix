{ pkgs, ... }:
{
  home.packages = with pkgs; [
    charmcraft
    juju
    juju4
    rockcraft
    snapcraft
  ];
}

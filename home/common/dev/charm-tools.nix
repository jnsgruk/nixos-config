{ pkgs
, ...
}: {
  home.packages = with pkgs; [
    charmcraft
    juju
    rockcraft
    snapcraft
  ];
}

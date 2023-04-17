{ pkgs
, ...
}: {
  home.packages = with pkgs; [
    juju
    charmcraft
  ];
}

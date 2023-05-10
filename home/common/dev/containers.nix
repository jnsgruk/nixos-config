{ pkgs, ... }: {
  home.packages = with pkgs; [
    ctop
    dive
    kubectl
    skopeo
  ];
}

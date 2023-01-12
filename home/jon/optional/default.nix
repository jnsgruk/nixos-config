{ pkgs, ... }: {
  home.packages = with pkgs; [
    (callPackage ./pkg.nix { })
  ];
}

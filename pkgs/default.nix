{pkgs}: {
  rambox = pkgs.callPackage ./rambox.nix {};
  sfpro-font = pkgs.callPackage ./sfpro-font.nix {};
  sf-mono-liga-font = pkgs.callPackage ./sf-mono-liga-font.nix {};
  sway-scripts = pkgs.callPackage ./sway-scripts {};
}

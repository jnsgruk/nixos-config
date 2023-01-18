{pkgs}: {
  catppuccin-macchiato-gtk = pkgs.callPackage ./catppuccin-macchiato-gtk.nix {};
  rambox = pkgs.callPackage ./rambox.nix {};
  sfpro-font = pkgs.callPackage ./sfpro-font.nix {};
  sf-mono-liga-font = pkgs.callPackage ./sf-mono-liga-font.nix {};
  sway-scripts = pkgs.callPackage ./sway-scripts {};

  charmcraft = pkgs.callPackage ./charmcraft {};
}

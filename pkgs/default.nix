{ pkgs }: {
  catppuccin-macchiato-gtk = pkgs.callPackage ./catppuccin-macchiato-gtk.nix { };
  sfpro-font = pkgs.callPackage ./sfpro-font.nix { };
  sf-mono-liga-font = pkgs.callPackage ./sf-mono-liga-font.nix { };
  sway-scripts = pkgs.callPackage ./sway-scripts { };
}

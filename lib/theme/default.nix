{ inputs, outputs, ... }:
let
  inherit (inputs.nixpkgs) lib;
  inherit ((import ./colours.nix)) colours;
  libx = import ./lib.nix { inherit lib; };

  pkgs = import inputs.unstable {
    system = "x86_64-linux";
    overlays = [ outputs.overlays.fonts ];
    config = { allowUnfree = true; joypixels.acceptLicense = true; };
  };
in
{
  inherit (libx) hexToRgb;

  # Note that there are still places not covered by colour choices here such as:
  #  - bat
  #  - tmux
  #  - vim
  inherit colours;

  wallpaper = ./wallpapers/jokulsarlon.jpg;

  gtkTheme = {
    name = "Catppuccin-Macchiato-Standard-Blue-Dark";
    package = pkgs.catppuccin-gtk.override {
      size = "standard";
      variant = "macchiato";
      accents = [ "blue" ];
    };
  };

  qtTheme = {
    name = "Catppuccin-Macchiato-Blue";
    package = pkgs.catppuccin-kvantum.override { variant = "Macchiato"; accent = "Blue"; };
  };

  iconTheme = rec {
    name = "Papirus-Dark";
    package = pkgs.papirus-icon-theme;
    iconPath = "${package}/share/icons/${name}";
  };

  cursorTheme = {
    name = "Adwaita";
    package = pkgs.gnome.adwaita-icon-theme;
    size = 24;
  };

  fonts = {
    default = {
      name = "Inter";
      package = pkgs.inter;
      size = "11";
    };
    iconFont = {
      name = "Inter";
      package = pkgs.inter;
    };
    monospace = {
      name = "MesloLGSDZ Nerd Font Mono";
      package = pkgs.nerdfonts.override { fonts = [ "Meslo" ]; };
    };
    emoji = {
      name = "Joypixels";
      package = pkgs.joypixels;
    };
  };
}

{ config, pkgs, self, ... }:
let
  theme = import "${self}/lib/theme" { inherit pkgs; };
  rofiTheme = (import ./theme.nix { inherit theme pkgs config; }).theme;
in
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;

    theme = rofiTheme;
    terminal = "${pkgs.alacritty}/bin/alacritty";

    extraConfig = {
      modi = "drun";
      show-icons = true;
      drun-display-format = "{icon} {name}";
      disable-history = false;
      hide-scrollbar = true;
      display-drun = "   Apps ";
      sidebar-mode = true;
    };
  };

  home.packages = [ pkgs.bemoji ];
}

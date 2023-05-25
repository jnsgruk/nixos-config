{ config, desktop, pkgs, lib, theme, ... }:
let
  powermenu = (import ./powermenu { inherit config pkgs lib desktop theme; });
  rofiTheme = (import ./theme.nix { inherit theme pkgs config; }).theme;

  toRasi = (import ./lib.nix { inherit lib; }).toRasi;
in
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;

    theme = rofiTheme;
    terminal = "${pkgs.alacritty}/bin/alacritty";
    plugins = with pkgs; [
      rofi-calc
      rofi-emoji
    ];

    extraConfig = {
      modi = "drun,emoji,calc";
      show-icons = true;
      drun-display-format = "{icon} {name}";
      disable-history = false;
      hide-scrollbar = true;
      display-drun = "   Apps ";
      display-run = "   Run ";
      display-emoji = "   Emoji ";
      display-calc = "   Calc ";
      sidebar-mode = true;
    };
  };

  home = {
    packages = [ powermenu.rofi-power ];
    file = {
      ".config/rofi/powermenu.rasi".text = toRasi powermenu.theme;
    };
  };
}

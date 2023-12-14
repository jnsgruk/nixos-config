{ config, pkgs, theme, ... }:
let

  rofiTheme = (import ./theme.nix { inherit theme pkgs config; }).theme;
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
}

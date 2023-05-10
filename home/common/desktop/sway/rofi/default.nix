{ pkgs, ... }: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;

    theme = ./theme.rasi;
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

  home.file = {
    ".config/rofi/powermenu.rasi".source = ./powermenu.rasi;
  };
}

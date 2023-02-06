{ pkgs, ... }: {
  nixpkgs.overlays = [
    (_self: _super: { rofi = pkgs.rofi-wayland; })
  ];

  programs.rofi = {
    enable = true;

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
      display-run = "  Run ";
      display-window = " 﩯 Window ";
      display-Network = " 󰤨 Network ";
      display-emoji = "  Emoji ";
      display-calc = "  Calc ";
      sidebar-mode = true;
    };
  };
}

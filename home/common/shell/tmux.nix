_: {
  programs = {
    tmate.enable = true;

    tmux = {
      enable = true;
      catppuccin.enable = true;

      aggressiveResize = true;
      baseIndex = 1;
      clock24 = true;
      sensibleOnTop = true;
      # This should either be screen-256color or tmux-256color where it exists
      terminal = "tmux-256color";

      extraConfig = ''
        set -g status on
        set -g mouse on

        # Where this shows 'alacritty' - the value should be whatever $TERM is outside tmux
        set-option -ga terminal-overrides ",alacritty:Tc"

        # Catppuccin options
        set -g @catppuccin_host 'on'
        set -g @catppuccin_window_tabs_enabled 'on'
      '';
    };
  };
}

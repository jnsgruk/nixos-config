_: {
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    catppuccin.enable = true;

    changeDirWidgetOptions = [ "--preview 'tree -C {} | head -200'" ];

    defaultCommand = "rg --files";
    defaultOptions = [
      "--height 90%"
      "--border"
    ];

    fileWidgetCommand = "rg --files";
    fileWidgetOptions = [
      "--preview 'bat -n --color=always {}'"
      "--bind 'ctrl-/:change-preview-window(down|hidden|)'"
    ];

    tmux.enableShellIntegration = true;
  };
}

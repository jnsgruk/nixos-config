_: {
  catppuccin.fzf.enable = true;

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;

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
  };
}

{ ... }: {
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;

    changeDirWidgetOptions = [
      "--preview 'tree -C {} | head -200'"
    ];

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

    colors = {
      "bg+" = "#363a4f";
      "fg+" = "#cad3f5";
      "hl+" = "#ed8796";
      bg = "#24273a";
      fg = "#cad3f5";
      header = "#ed8796";
      hl = "#ed8796";
      info = "#c6a0f6";
      marker = "#f4dbd6";
      pointer = "#f4dbd6";
      prompt = "#c6a0f6";
      spinner = "#f4dbd6";
    };
  };
}

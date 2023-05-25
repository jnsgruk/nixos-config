{ theme, pkgs, ... }:
let
  colours = (theme { inherit pkgs; }).colours;
in
{
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
      "bg+" = "${colours.surface0}";
      "fg+" = "${colours.text}";
      "hl+" = "${colours.red}";
      bg = "${colours.bg}";
      fg = "${colours.text}";
      header = "${colours.red}";
      hl = "${colours.red}";
      info = "${colours.purple}";
      marker = "${colours.white}";
      pointer = "${colours.white}";
      prompt = "${colours.purple}";
      spinner = "${colours.white}";
    };
  };
}

{ pkgs, self, ... }:
let
  theme = import "${self}/lib/theme" { inherit pkgs; };
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
      "bg+" = "${theme.colours.surface0}";
      "fg+" = "${theme.colours.text}";
      "hl+" = "${theme.colours.red}";
      bg = "${theme.colours.bg}";
      fg = "${theme.colours.text}";
      header = "${theme.colours.red}";
      hl = "${theme.colours.red}";
      info = "${theme.colours.purple}";
      marker = "${theme.colours.white}";
      pointer = "${theme.colours.white}";
      prompt = "${theme.colours.purple}";
      spinner = "${theme.colours.white}";
    };
  };
}

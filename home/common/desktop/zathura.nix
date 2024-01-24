{ pkgs, ... }:
let
  theme = import ../../../lib/theme { inherit pkgs; };
in
{
  programs.zathura = {
    enable = true;
    options = {
      recolor = true;
      selection-clipboard = "clipboard";

      # Catppuccin Macchiato
      default-fg = "${theme.colours.text}";
      default-bg = "${theme.colours.bg}";
      completion-bg = "${theme.colours.surface0}";
      completion-fg = "${theme.colours.text}";
      completion-highlight-bg = "${theme.colours.surface2}";
      completion-highlight-fg = "${theme.colours.text}";
      completion-group-bg = "${theme.colours.surface0}";
      completion-group-fg = "${theme.colours.darkBlue}";
      statusbar-fg = "${theme.colours.text}";
      statusbar-bg = "${theme.colours.surface0}";
      notification-bg = "${theme.colours.surface0}";
      notification-fg = "${theme.colours.text}";
      notification-error-bg = "${theme.colours.surface0}";
      notification-error-fg = "${theme.colours.red}";
      notification-warning-bg = "${theme.colours.surface0}";
      notification-warning-fg = "${theme.colours.orange}";
      inputbar-fg = "${theme.colours.text}";
      inputbar-bg = "${theme.colours.surface0}";
      recolor-lightcolor = "${theme.colours.bg}";
      recolor-darkcolor = "${theme.colours.text}";
      index-fg = "${theme.colours.text}";
      index-bg = "${theme.colours.bg}";
      index-active-fg = "${theme.colours.text}";
      index-active-bg = "${theme.colours.surface0}";
      render-loading-bg = "${theme.colours.bg}";
      render-loading-fg = "${theme.colours.text}";
      highlight-color = "${theme.colours.surface2}";
      highlight-fg = "${theme.colours.pink}";
      highlight-active-color = "${theme.colours.pink}";
    };
  };
}

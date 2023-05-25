{ theme, pkgs, ... }:
let
  colours = (theme { inherit pkgs; }).colours;
in
{
  programs.zathura = {
    enable = true;
    options = {
      recolor = true;
      selection-clipboard = "clipboard";

      # Catppuccin Macchiato
      default-fg = "${colours.text}";
      default-bg = "${colours.bg}";
      completion-bg = "${colours.surface0}";
      completion-fg = "${colours.text}";
      completion-highlight-bg = "${colours.surface2}";
      completion-highlight-fg = "${colours.text}";
      completion-group-bg = "${colours.surface0}";
      completion-group-fg = "${colours.darkBlue}";
      statusbar-fg = "${colours.text}";
      statusbar-bg = "${colours.surface0}";
      notification-bg = "${colours.surface0}";
      notification-fg = "${colours.text}";
      notification-error-bg = "${colours.surface0}";
      notification-error-fg = "${colours.red}";
      notification-warning-bg = "${colours.surface0}";
      notification-warning-fg = "${colours.orange}";
      inputbar-fg = "${colours.text}";
      inputbar-bg = "${colours.surface0}";
      recolor-lightcolor = "${colours.bg}";
      recolor-darkcolor = "${colours.text}";
      index-fg = "${colours.text}";
      index-bg = "${colours.bg}";
      index-active-fg = "${colours.text}";
      index-active-bg = "${colours.surface0}";
      render-loading-bg = "${colours.bg}";
      render-loading-fg = "${colours.text}";
      highlight-color = "${colours.surface2}";
      highlight-fg = "${colours.pink}";
      highlight-active-color = "${colours.pink}";
    };
  };
}

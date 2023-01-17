{...}: {
  programs.zathura = {
    enable = true;
    options = {
      recolor = true;
      selection-clipboard = "clipboard";

      # Catppuccin Macchiato
      default-fg = "#CAD3F5";
      default-bg = "#24273A";
      completion-bg = "#363A4F";
      completion-fg = "#CAD3F5";
      completion-highlight-bg = "#575268";
      completion-highlight-fg = "#CAD3F5";
      completion-group-bg = "#363A4F";
      completion-group-fg = "#8AADF4";
      statusbar-fg = "#CAD3F5";
      statusbar-bg = "#363A4F";
      notification-bg = "#363A4F";
      notification-fg = "#CAD3F5";
      notification-error-bg = "#363A4F";
      notification-error-fg = "#ED8796";
      notification-warning-bg = "#363A4F";
      notification-warning-fg = "#FAE3B0";
      inputbar-fg = "#CAD3F5";
      inputbar-bg = "#363A4F";
      recolor-lightcolor = "#24273A";
      recolor-darkcolor = "#CAD3F5";
      index-fg = "#CAD3F5";
      index-bg = "#24273A";
      index-active-fg = "#CAD3F5";
      index-active-bg = "#363A4F";
      render-loading-bg = "#24273A";
      render-loading-fg = "#CAD3F5";
      highlight-color = "#575268";
      highlight-fg = "#F5BDE6";
      highlight-active-color = "#F5BDE6";
    };
  };
}

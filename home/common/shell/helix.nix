_: {
  programs.helix = {
    enable = true;
    settings = {
      theme = "catppuccin_macchiato";
      editor = {
        text-width = 100;
        rulers = [ 100 ];
        lsp = {
          display-inlay-hints = true;
        };
      };
    };
  };
}

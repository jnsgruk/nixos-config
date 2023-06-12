{ ... }: {
  programs.helix = {
    enable = true;
    settings = {
      theme = "catppuccin_macchiato";
      editor = {
        bufferline = "multiple";
        color-modes = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        cursorline = true;
        file-picker.hidden = false;
        indent-guides = {
          render = true;
        };
        text-width = 100;
        rulers = [ 100 ];
      };
    };
    languages = {
      nix.auto-format = true;
      go.auto-format = true;
      python = {
        auto-format = true;
        formatter = {
          command = "black";
          args = [ "-l100" "--quiet" "-" ];
        };
        config = {
          pylsp = {
            plugins = {
              ruff = {
                enabled = true;
                lineLength = 100;
              };
            };
          };
        };
      };
    };
  };
}

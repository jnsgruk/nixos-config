{ pkgs, lib, ... }: {
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
  };

  # The home-manager module doesn't seem to work right specifying LSP options
  # at the moment, so reverting to setting the file up manually.
  xdg.configFile."helix/languages.toml".text = ''
    [[language]]
    name = "nix"
    auto-format = true
    language-server = { command = "${lib.getExe pkgs.nil}" }
    formatter = { command = "${lib.getExe pkgs.nixpkgs-fmt}" }

    [[language]]
    name = "python"
    auto-format = true
    formatter = { command = "black", args = ["-l99", "-q", "-"]}

    [[language]]
    name = "go"
    auto-format = true
  '';
}

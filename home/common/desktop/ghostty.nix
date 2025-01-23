{ pkgs, self, ... }:
let
  theme = import "${self}/lib/theme" { inherit pkgs; };
in
{
  programs.ghostty = {
    enable = true;
    settings = {
      theme = "catppucin-macchiato";
      font-family = "${theme.fonts.monospace.name}";
      font-size = 14;
      window-padding-x = 10;
      window-padding-y = 10;
    };
  };
}

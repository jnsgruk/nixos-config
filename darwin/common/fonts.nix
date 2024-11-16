{ self, pkgs, ... }:
let
  theme = import "${self}/lib/theme" { inherit pkgs; };
in
{
  fonts = {
    packages = [
      theme.fonts.default.package
      theme.fonts.iconFont.package
      theme.fonts.monospace.package
    ];
  };
}

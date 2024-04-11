{
  pkgs,
  self,
  hostname,
  ...
}:
let
  theme = import "${self}/lib/theme" { inherit pkgs; };
in
{
  services = {
    mako = {
      enable = true;
      catppuccin.enable = true;
      actions = true;
      anchor = if hostname == "kara" then "top-center" else "top-right";
      borderRadius = 8;
      borderSize = 1;
      defaultTimeout = 10000;
      font = "${theme.fonts.default.name}";
      iconPath = "${theme.iconTheme.iconPath}";
      icons = true;
      layer = "overlay";
      maxVisible = 3;
      padding = "10";
      width = 300;
    };
  };
}

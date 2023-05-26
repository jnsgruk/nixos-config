{ pkgs, theme, ... }:
let
  defaults = theme { inherit pkgs; };
  colours = defaults.colours;
in
{
  services = {
    mako = {
      enable = true;
      actions = true;
      anchor = "top-right";
      borderRadius = 8;
      borderSize = 1;
      defaultTimeout = 10000;
      font = "${defaults.fonts.default.name}";
      iconPath = "${defaults.iconTheme.iconPath}";
      icons = true;
      layer = "overlay";
      maxVisible = 3;
      padding = "10";
      width = 300;

      backgroundColor = "${colours.bg}";
      borderColor = "${colours.accent}";
      progressColor = "over ${colours.surface0}";
      textColor = "${colours.text}";

      extraConfig = ''
        [urgency=high]
        border-color=${colours.orange}
      '';
    };
  };
}

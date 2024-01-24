{ pkgs, ... }:
let
  theme = import ../../../lib/theme { inherit pkgs; };
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
      font = "${theme.fonts.default.name}";
      iconPath = "${theme.iconTheme.iconPath}";
      icons = true;
      layer = "overlay";
      maxVisible = 3;
      padding = "10";
      width = 300;

      backgroundColor = "${theme.colours.bg}";
      borderColor = "${theme.colours.accent}";
      progressColor = "over ${theme.colours.surface0}";
      textColor = "${theme.colours.text}";

      extraConfig = ''
        [urgency=high]
        border-color=${theme.colours.orange}
      '';
    };
  };
}

{ pkgs, ... }: {
  services = {
    mako = {
      enable = true;
      actions = true;
      anchor = "top-right";
      borderRadius = 0;
      borderSize = 1;
      defaultTimeout = 10000;
      font = "SF Pro";
      iconPath = "${pkgs.papirus-icon-theme}/share/icons/Papirus-Dark";
      icons = true;
      layer = "overlay";
      maxVisible = 5;
      padding = "20";
      width = 450;

      backgroundColor = "#24273a";
      borderColor = "#8aadf4";
      progressColor = "over #363a4f";
      textColor = "#cad3f5";

      extraConfig = ''
        [urgency=high]
        border-color=#f5a97f
      '';
    };
  };
}

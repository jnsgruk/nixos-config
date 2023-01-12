{...}: {
  programs = {
    mako = {
      enable = true;
      textColor = "#cdd6f4";
      backgroundColor = "#1e1e2e";
      borderColor = "#89b4fa";
      defaultTimeout = 5000;
      progressColor = "#313244";
      extraConfig = ''
        [urgency=high]
        border-color=#fab387
      '';
    };
  };
}

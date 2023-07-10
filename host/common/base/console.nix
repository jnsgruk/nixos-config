{ pkgs
, theme
, ...
}: {
  console = {
    earlySetup = true;
    packages = with pkgs; [ terminus_font powerline-fonts ];
    font = "ter-powerline-v32n";
  };

  services.kmscon = {
    enable = true;
    hwRender = true;
    fonts = [{
      name = "${theme.fonts.monospace.name}";
      package = theme.fonts.monospace.package;
    }];
    extraConfig = ''
      font-size=14
    '';
    extraOptions = "--xkb-layout=gb";
  };
}

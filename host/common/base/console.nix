{ pkgs, self, ... }:
let
  theme = import "${self}/lib/theme" { inherit pkgs; };
  inherit (theme) colours hexToRgb;
in
{
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
      inherit (theme.fonts.monospace) package;
    }];
    extraConfig = ''
      font-size=14

      xkb-layout=gb

      palette=custom
      palette-black=${hexToRgb colours.surface1}
      palette-red=${hexToRgb colours.red}
      palette-green=${hexToRgb colours.green}
      palette-yellow=${hexToRgb colours.yellow}
      palette-blue=${hexToRgb colours.darkBlue}
      palette-magenta=${hexToRgb colours.pink}
      palette-cyan=${hexToRgb colours.cyan}
      palette-light-grey=${hexToRgb colours.overlay2}
      palette-dark-grey=${hexToRgb colours.overlay0}
      palette-light-red=${hexToRgb colours.red}
      palette-light-green=${hexToRgb colours.green}
      palette-light-yellow=${hexToRgb colours.yellow}
      palette-light-blue=${hexToRgb colours.darkBlue}
      palette-light-magenta=${hexToRgb colours.pink}
      palette-light-cyan=${hexToRgb colours.cyan}
      palette-white=${hexToRgb colours.subtext1}
      palette-foreground=${hexToRgb colours.text}
      palette-background=${hexToRgb colours.bg}
    '';
  };
}

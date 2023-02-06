{
  lib,
  pkgs,
  ...
}:
pkgs.stdenvNoCC.mkDerivation {
  name = "sway-scripts";
  dontConfigue = true;

  src = ./src;

  # TODO: Figure out if there is a way to add dependencies on the tools used by the scripts

  installPhase = ''
    mkdir -p $out/bin
    install -Dm 744 ${./src/sharescreen} $out/bin/sharescreen
    install -Dm 744 ${./src/sway-screenshot} $out/bin/sway-screenshot
    install -Dm 744 ${./src/waybar-power-menu} $out/bin/waybar-power-menu
  '';

  meta = with lib; {
    description = "A collection of scripts for use with my sway setup";
    maintainers = [jnsgruk];
  };
}

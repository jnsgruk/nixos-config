{ lib
, pkgs
, ...
}:
let
  screenshotDeps = with pkgs; [
    grim
    jq
    slurp
    swappy
    sway
  ];

  sharescreenDeps = with pkgs; [
    linuxPackages.v4l2loopback
    python3
    slurp
    sway
    wf-recorder
  ];

in
pkgs.stdenvNoCC.mkDerivation {
  name = "sway-scripts";
  dontConfigue = true;

  src = ./src;

  nativeBuildInputs = [ pkgs.makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin
    install -Dm 744 sharescreen $out/bin/sharescreen
    wrapProgram $out/bin/sharescreen --prefix PATH : '${lib.makeBinPath sharescreenDeps}'

    install -Dm 744 sway-screenshot $out/bin/sway-screenshot
    wrapProgram $out/bin/sway-screenshot --prefix PATH : '${lib.makeBinPath screenshotDeps}'

    install -Dm 744 waybar-power-menu $out/bin/waybar-power-menu
    wrapProgram $out/bin/waybar-power-menu --prefix PATH : '${lib.makeBinPath [pkgs.sway]}'

    install -Dm 744 sway-run $out/bin/sway-run
    wrapProgram $out/bin/sway-run --prefix PATH : '${lib.makeBinPath [pkgs.sway]}'
  '';

  meta = with lib; {
    description = "A collection of scripts for use with my sway setup";
    maintainers = [ jnsgruk ];
  };
}

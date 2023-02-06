{ lib
, pkgs
, ...
}:
let
  rev = "7723040ef50633da5094f01f93b96dae5e9b9299";
in
pkgs.stdenvNoCC.mkDerivation {
  name = "sf-mono-liga-font";
  dontConfigue = true;

  src = pkgs.fetchzip {
    url = "https://github.com/shaunsingh/SFMono-Nerd-Font-Ligaturized/archive/${rev}.zip";
    sha256 = "sha256-tGLBqpoXnkecn1MFuOc9QHucWeIymgLFJNz5Bz7Mhwg=";
    stripRoot = false;
  };

  installPhase = ''
    mkdir -p $out/share/fonts
    cp -R $src $out/share/fonts/opentype/
  '';

  meta = with lib; {
    description = "A patched San Franciso Mono with ligatures font derivation.";
    maintainers = [ jnsgruk ];
  };
}

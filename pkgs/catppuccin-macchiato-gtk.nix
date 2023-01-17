{
  lib,
  stdenv,
  fetchzip,
  pkgs,
  ...
}:
stdenv.mkDerivation {
  pname = "cattpuccin-macchiato-gtk";
  version = "0.4.0";

  src = fetchzip {
    url = "https://github.com/catppuccin/gtk/releases/download/v0.4.0/Catppuccin-Macchiato-Standard-Blue-Dark.zip";
    sha256 = "sha256-T/RntAyf10BNNtcOUguDQZwGukIF84NuuToZ/+6tJ9c=";
    stripRoot = false;
  };

  propagatedUserEnvPkgs = with pkgs; [
    gnome.gnome-themes-extra
    gtk-engine-murrine
  ];

  installPhase = ''
    mkdir -p $out/share/themes/
    cp -r Catppuccin-Macchiato-Standard-Blue-Dark $out/share/themes
    cp -r Catppuccin-Macchiato-Standard-Blue-Dark-hdpi $out/share/themes
    cp -r Catppuccin-Macchiato-Standard-Blue-Dark-xhdpi $out/share/themes
  '';

  meta = with lib; {
    description = "Soothing pastel theme for GTK3";
    homepage = "https://github.com/catppuccin/gtk";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.unix;
    maintainers = [lib.maintainers.jnsgruk];
  };
}

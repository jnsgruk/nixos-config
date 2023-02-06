{ lib
, fetchurl
, appimageTools
,
}:
let
  pname = "rambox";
  version = "2.0.10";
  name = "${pname}-${version}";
  src = fetchurl {
    url = "https://rambox.app/api/download?os=linux&package=AppImage";
    hash = "sha256-NvsrWkdINrQV7V9SLfjtlN+obgQb0u8d/QgjGpZ+fpc=";
  };
  appImageContents = appimageTools.extractType2 {
    inherit name src;
  };
in
appimageTools.wrapType2 {
  inherit name src;
  extraInstallCommands = ''
    mv $out/bin/${name} $out/bin/${pname}
    mkdir -p $out/share/applications
    install -Dm 644 ${appImageContents}/${pname}.desktop $out/share/applications/
    substituteInPlace \
      $out/share/applications/${pname}.desktop \
      --replace "AppRun" "${pname}"
  '';

  meta = with lib; {
    description = "Messaging and emailing app that combines common web applications into one";
    homepage = "https://rambox.pro";
  };
}

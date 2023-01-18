{
  pkgs,
  lib,
  ...
}:
pkgs.python3Packages.buildPythonPackage rec {
  pname = "overrides";
  version = "7.3.1";

  src = pkgs.python3Packages.fetchPypi {
    inherit pname version;
    sha256 = "sha256-i5fGweFoG3jLyUJLE42IDwgDwiVMXrqr3eV7tsYgk/I=";
  };

  doCheck = false;

  meta = with lib; {
    description = "A decorator @override that verifies that a method that should override an inherited method actually does it.";
    homepage = "https://github.com/mkorpela/overrides";
    license = licenses.asl20;
    maintainers = with maintainers; [jnsgruk];
  };
}

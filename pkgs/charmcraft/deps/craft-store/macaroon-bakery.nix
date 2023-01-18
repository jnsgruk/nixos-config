{
  pkgs,
  lib,
  ...
}:
pkgs.python3Packages.buildPythonPackage rec {
  pname = "macaroonbakery";
  version = "1.3.1";

  src = pkgs.python3Packages.fetchPypi {
    inherit pname version;
    sha256 = "sha256-I/OEFTQaHQShVbTaxnMNOtXzm4bOB7G7E0vdpStIsFM=";
  };

  propagatedBuildInputs = with pkgs.python3Packages; [
    protobuf3
    pymacaroons
    pynacl
    pyRFC3339
    requests
  ];

  doCheck = false;

  meta = with lib; {
    description = "A Python library for working with macaroons.";
    homepage = "https://github.com/go-macaroon-bakery/py-macaroon-bakery";
    license = licenses.lgpl3;
    maintainers = with maintainers; [jnsgruk];
  };
}

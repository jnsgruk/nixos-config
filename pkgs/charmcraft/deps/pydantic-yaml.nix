{
  pkgs,
  lib,
  pydantic,
  ...
}: let
  types-deprecated = pkgs.python3Packages.buildPythonPackage rec {
    pname = "types-Deprecated";
    version = "1.2.9";

    src = pkgs.python3Packages.fetchPypi {
      inherit pname version;
      sha256 = "sha256-4EzliSlQmGU1npHcw4cgEjJitM1o+iqKkDEtUDkLtvo=";
    };
  };
in
  pkgs.python3Packages.buildPythonPackage rec {
    pname = "pydantic_yaml";
    version = "0.9.0";

    src = pkgs.python3Packages.fetchPypi {
      inherit pname version;
      sha256 = "sha256-Jtldg9Z2j8f4CyJjUNujql3J9SwTBhaVFx6Nnny0z0o=";
    };

    propagatedBuildInputs = with pkgs.python3Packages;
      [
        deprecated
        semver
      ]
      ++ [
        pydantic
        types-deprecated
      ];

    doCheck = false;

    meta = with lib; {
      description = "A small helper library that adds some YAML capabilities to pydantic.";
      homepage = "https://github.com/NowanIlfideme/pydantic-yaml";
      license = licenses.mit;
      maintainers = with maintainers; [jnsgruk];
    };
  }

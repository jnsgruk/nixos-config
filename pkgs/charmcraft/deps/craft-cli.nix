{
  pkgs,
  lib,
  pydantic,
  ...
}:
pkgs.python3Packages.buildPythonPackage rec {
  pname = "craft-cli";
  version = "1.2.0";

  src = pkgs.fetchFromGitHub {
    owner = "canonical";
    repo = "craft-cli";
    rev = version;
    sha256 = "sha256-kNaAvuZarAq/qo7g9htd0Y65SQ/zjrbKmDSAfAj+ydw=";
  };

  propagatedBuildInputs = with pkgs.python3Packages;
    [
      platformdirs
      pyyaml
    ]
    ++ [pydantic];

  doCheck = false;

  meta = with lib; {
    description = "A Command Line Client builder that follows the Canonical's Guidelines for a Command Line Interface.";
    homepage = "https://github.com/canonical/craft-cli";
    license = licenses.lgpl3;
    maintainers = with maintainers; [jnsgruk];
  };
}

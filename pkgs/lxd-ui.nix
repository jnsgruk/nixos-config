{ pkgs, ... }: pkgs.mkYarnPackage rec {
  pname = "lxd-ui";
  version = "0.0.1";

  src = pkgs.fetchFromGitHub {
    owner = "canonical";
    repo = "lxd-ui";
    rev = "418f30b865d120b1f6596ed08b24c2584daac3a7";
    sha256 = "sha256-20ExF7QMFevtTE2lCsOleTI0NH8KwHSy4QvLiOGfE7s=";
  };

  packageJSON = "${src}/package.json";

  offlineCache = pkgs.fetchYarnDeps {
    yarnLock = "${src}/yarn.lock";
    sha256 = "sha256-axBRaC5aoznTYRcyOATo6x78HRBlhuMVKLxGcHLhVuA=";
  };

  buildPhase = ''
    yarn --offline build
  '';

  installPhase = ''
    cp -rv deps/lxd-ui/build/ $out
  '';

  doDist = false;
}

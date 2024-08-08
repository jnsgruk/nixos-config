{ pkgs }:
let
  inherit (pkgs) buildGo122Module fetchFromGitHub installShellFiles;
in
buildGo122Module {
  pname = "juju4";
  version = "4.0-unstable-2024-08-08";

  src = fetchFromGitHub {
    owner = "juju";
    repo = "juju";
    rev = "e4724547ea17482dea30541463973600e172d878";
    hash = "sha256-HQ7QPR3bfHKog5b7qw6rsWZyrwvfL/KRSzHSi+Lh+14=";
  };

  vendorHash = "sha256-zRGxS2QFukI7AKgC8XHon/iH6bzrEsGjFPFf8CLJp4o=";

  subPackages = [ "cmd/juju" ];

  nativeBuildInputs = [ installShellFiles ];

  doCheck = false;

  postInstall = ''
    mv $out/bin/juju $out/bin/juju4
  '';
}

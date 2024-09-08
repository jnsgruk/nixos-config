{ pkgs }:
let
  inherit (pkgs) buildGo123Module fetchFromGitHub installShellFiles;
in
buildGo123Module {
  pname = "juju4";
  version = "4.0-unstable-2024-09-08";

  src = fetchFromGitHub {
    owner = "juju";
    repo = "juju";
    rev = "e51606a12490923092eb8f99882b2c4de7f4af7a";
    hash = "sha256-UZUQqlUzsjf52BJ8lGMWqUM+pKDHplMZLlcHFQY4c1c=";
  };

  vendorHash = "sha256-KzR7JCjmfGe5nNuXAk4SsxGdpXjzV1+Dc7YOQc1TwcQ=";

  subPackages = [ "cmd/juju" ];

  nativeBuildInputs = [ installShellFiles ];

  doCheck = false;

  postInstall = ''
    mv $out/bin/juju $out/bin/juju4
  '';
}

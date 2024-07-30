{ pkgs }:
let
  inherit (pkgs) buildGo122Module fetchFromGitHub installShellFiles;
in
buildGo122Module {
  pname = "juju4";
  version = "4.0-unstable-2024-07-25";

  src = fetchFromGitHub {
    owner = "juju";
    repo = "juju";
    rev = "32595332427ad5d24e60794dea074a1a03472775";
    hash = "sha256-tGlVnjAiwOPgZiJ19P3DKnMfvSzGP0e/F4y+/K9Xlc0=";
  };

  vendorHash = "sha256-viXALaiAFLKAYVfmLraL0uncEIJq4a9Tdgo4u5cdsCA=";

  subPackages = [ "cmd/juju" ];

  nativeBuildInputs = [ installShellFiles ];

  doCheck = false;

  postInstall = ''
    for file in etc/bash_completion.d/*; do
      installShellCompletion --bash "$file"
    done

    mv $out/bin/juju $out/bin/juju4
  '';
}

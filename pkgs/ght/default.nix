{ lib, pkgs, ... }:
pkgs.buildNpmPackage rec {
  pname = "ght";
  version = "1.11.1-unstable-2024-10-16";

  src = pkgs.fetchFromGitHub {
    owner = "canonical";
    repo = "ght";
    # rev = "refs/tags/v${version}";
    rev = "f62ce1ae6b15932cd93d9bb84e8b54973147e214";
    hash = "sha256-reSMagnP+pHfqGhwX+34nRZzNNrKPR1eTWCFFsivQTM=";
  };

  npmDeps = pkgs.fetchNpmDeps {
    inherit src;
    hash = "sha256-6/Ug6BO0/B/O5ZuwCQzo8z+kjFiO9Ha9s03jCy/uL5Q=";
  };

  patches = [ ./ght-graders-loc.patch ];

  postPatch = ''
    substituteInPlace ght \
        --replace-fail "./index.js" "$out/opt/ght/index.js" \
        --replace-fail "./package.json" "$out/opt/ght/package.json"
  '';

  env.PUPPETEER_SKIP_DOWNLOAD = true;

  installPhase = ''
    mkdir -p $out/bin $out/opt

    # Copy the built tool & node_modules into the output
    cp -r dist $out/opt/ght
    cp -r node_modules $out/opt/ght/node_modules

    # Copy the 'binary' into place
    cp ght $out/bin/ght

    # Make sure that chromium is available and puppeteer knows to use it
    wrapProgram $out/bin/ght \
        --set PUPPETEER_EXECUTABLE_PATH ${pkgs.chromium.outPath}/bin/chromium
  '';

  meta = {
    mainProgram = "ght";
    description = "Perform actions in Greenhouse from you terminal";
    homepage = "https://github.com/canonical/ght";
    changelog = "https://github.com/canonical/ght/releases/tag/v${version}";
    maintainers = with lib.maintainers; [ jnsgruk ];
  };
}

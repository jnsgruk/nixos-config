{ pkgs
, lib
, ...
}:
let
  common = import ./common.nix { inherit pkgs; };
  inherit (common) name version repo vendorHash;

  frontend = pkgs.buildNpmPackage rec {
    inherit version;
    pname = "${name}-webapp-frontend";
    src = "${repo}/webapp/frontend";

    npmDepsHash = "sha256-M8P41LPg7oJ/C9abDuNM5Mn+OO0zK56CKi2BwLxv8oQ=";

    buildPhase = ''
      runHook preBuild
      mkdir dist
      npm run build:prod --offline -- --output-path=dist
      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall
      mkdir $out
      cp -r dist/* $out
      runHook postInstall
    '';
  };
in
pkgs.buildGoModule rec {
  inherit version vendorHash;
  pname = "${name}-webapp-backend";
  src = repo;

  CGO_ENABLED = 0;

  buildPhase = ''
    runHook preBuild
    go build \
      -o scrutiny-web \
      -ldflags="-extldflags=-static" \
      -tags "static netgo" \
      ./webapp/backend/cmd/scrutiny
    runHook postBuild
  '';

  installPhase = ''
    mkdir -p $out/bin $out/share/scrutiny
    cp scrutiny-web $out/bin/scrutiny-web
    cp -r ${frontend}/* $out/share/scrutiny
  '';

  meta = {
    description = "Hard Drive S.M.A.R.T Monitoring, Historical Trends & Real World Failure Thresholds.";
    homepage = "https://github.com/AnalogJ/scrutiny";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ jnsgruk ];
  };
}

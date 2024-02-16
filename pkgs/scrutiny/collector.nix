{ pkgs
, lib
, ...
}:
let
  common = import ./common.nix { inherit pkgs; };
  inherit (common) name version repo vendorHash;
in
pkgs.buildGoModule rec {
  inherit version vendorHash;
  pname = "${name}-collector";
  src = repo;

  buildInputs = with pkgs; [
    makeWrapper
  ];

  CGO_ENABLED = 0;

  buildPhase = ''
    runHook preBuild
    go build \
      -o scrutiny-collector-metrics \
      -ldflags="-extldflags=-static" \
      -tags "static netgo" \
      ./collector/cmd/collector-metrics
    runHook postBuild
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp scrutiny-collector-metrics $out/bin/scrutiny-collector-metrics
    
    wrapProgram $out/bin/scrutiny-collector-metrics \
      --prefix PATH : ${lib.makeBinPath [ pkgs.smartmontools ]}
  '';

  meta = {
    description = "Hard disk metrics collector for Scrutiny.";
    homepage = "https://github.com/AnalogJ/scrutiny";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ jnsgruk ];
  };
}

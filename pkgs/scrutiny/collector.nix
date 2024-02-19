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
  subPackages = "collector/cmd/collector-metrics/collector-metrics.go";

  buildInputs = with pkgs; [
    makeWrapper
  ];

  CGO_ENABLED = 0;

  ldflags = [ "-extldflags=-static" ];

  tags = [
    "netgo"
    "static"
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp $GOPATH/bin/collector-metrics $out/bin/scrutiny-collector-metrics
    wrapProgram $out/bin/scrutiny-collector-metrics \
      --prefix PATH : ${lib.makeBinPath [ pkgs.smartmontools ]}
  '';

  meta = {
    description = "Hard disk metrics collector for Scrutiny.";
    homepage = "https://github.com/AnalogJ/scrutiny";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ jnsgruk ];
    mainProgram = "scrutiny-collector-metrics";
  };
}

{ pkgs, lib, ... }: pkgs.buildNpmPackage rec {
  pname = "homepage-server";
  version = "v0.6.21";

  src = pkgs.fetchFromGitHub {
    owner = "benphelps";
    repo = "homepage";
    rev = "${version}";
    sha256 = "sha256-kjxA02hJj/GAQ0fM1xTtXAnZSQgVyE+EMRrXis1Vr+o=";
  };

  npmDepsHash = "sha256-O6SQYx5vxscMsbWv0ynUYqdUkOp/nMtdvlZ/Mp95sBY=";

  patches = [ ./config-dir.patch ];

  postPatch = ''
    mkdir -p config
  '';

  buildInputs = with pkgs;[
    nodePackages.node-gyp-build
    python3
  ];

  PYTHON = "${lib.getExe pkgs.python3}";

  installPhase = ''
    cp -r .next/standalone $out
    cp -r public $out/public
    
    mkdir -p $out/.next
    cp -r .next/static $out/.next/static
  '';

  doDist = false;

  meta = {
    description = "A highly customizable homepage (or startpage / application dashboard) with Docker and service API integrations.";
    homepage = "https://gethomepage.dev";
    license = with lib.licenses; [ gpl3 ];
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [ jnsgruk ];
  };
}

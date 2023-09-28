{ lib
, pkgs
, ...
}:
let
  pname = "ght";
  version = "1.5.6";

  src = pkgs.fetchFromGitHub {
    owner = "canonical";
    repo = pname;
    # When bumping the version, a new 'yarn.lock' will need to be generated.
    # To do this:
    # - Clone the source code, cd into the directory
    # - Run 'nix shell nixpkgs#yarn nixpkgs#yarn2nix'
    # - Run 'yarn install'
    # - Copy the new 'yarn.lock' into this directory, overwriting the old
    rev = "v${version}";
    sha256 = "sha256-6WiHVXxwShQKwkBvlkDNgGt1Kp3qK5s9fulpXsNJsnU=";
  };

  packageJSON = "${src}/package.json";
  # TODO: Try to drop this "forked" yarn.lock and generate it somehow?
  yarnLock = ./yarn.lock;

  # Grab the node_modules required to build/run the ght tool
  yarnDeps = pkgs.mkYarnModules {
    inherit version packageJSON yarnLock;
    pname = "ght-yarn-deps";
  };
in
pkgs.mkYarnPackage {
  inherit src pname version yarnLock packageJSON;

  nativeBuildInputs = with pkgs; [ makeWrapper ];

  postPatch = ''
    substituteInPlace ght \
        --replace "./index.js" "$out/opt/ght/index.js" \
        --replace "./package.json" "$out/opt/ght/package.json"
  '';

  configurePhase = ''
    ln -s $node_modules node_modules
  '';

  buildPhase = ''
    export HOME=$(mktemp -d)
    yarn --offline build
  '';

  installPhase = ''
    mkdir -p $out/bin $out/opt
    
    # Copy the built tool & node_modules into the output
    cp -r dist $out/opt/ght
    ln -sf ${yarnDeps}/node_modules $out/opt/ght/node_modules
    
    # Copy the 'binary' into place
    cp ght $out/bin/ght

    # Make sure that chromium is available and puppeteer knows to use it
    wrapProgram $out/bin/ght \
        --set PUPPETEER_EXECUTABLE_PATH ${pkgs.chromium.outPath}/bin/chromium
  '';

  distPhase = "true";

  meta = with lib; {
    description = "Perform actions in Greenhouse from you terminal.";
    maintainers = [ jnsgruk ];
  };
}


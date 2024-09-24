{ pkgs, lib, ... }:
pkgs.buildGoModule {
  pname = "spread";
  version = "0-unstable-2024-09-24";

  src = pkgs.fetchFromGitHub {
    owner = "snapcore";
    repo = "spread";
    rev = "ded9133cdbceaf01f8a1c9decf6ff9ea56e194d6";
    hash = "sha256-uHBzVABfRCyBAGP9f+2GS49Qc8R9d1HaRr6bYPeVSU4=";
  };

  vendorHash = "sha256-SULAfCLtNSnuUXvA33I48hnhU0Ixq79HhADPIKYkWNU=";

  subPackages = [ "cmd/spread" ];

  nativeBuildInputs = with pkgs; [ makeWrapper ];

  patches = [ ./local-script-path.patch ];

  postPatch = ''
    # Replace direct calls to /bin/bash
    substituteInPlace spread/lxd.go --replace-fail '"/bin/bash", ' '"/usr/bin/env", "bash", '
    substituteInPlace spread/client.go --replace-fail '"/bin/bash", ' '"/usr/bin/env", "bash", '
    substituteInPlace spread/project.go --replace-fail '"/bin/bash", ' '"/usr/bin/env", "bash", '
  '';

  postInstall = ''
    wrapProgram $out/bin/spread --prefix PATH ${
      lib.makeBinPath [
        pkgs.bash
        pkgs.coreutils
        pkgs.gnutar
        pkgs.gzip
      ]
    }
  '';

  meta = {
    mainProgram = "spread";
    description = "Convenient full-system test (task) distribution";
    homepage = "https://github.com/snapcore/spread";
    maintainers = with lib.maintainers; [ jnsgruk ];
  };
}

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

  meta = {
    mainProgram = "spread";
    description = "Convenient full-system test (task) distribution";
    homepage = "https://github.com/snapcore/spread";
    maintainers = with lib.maintainers; [ jnsgruk ];
  };
}

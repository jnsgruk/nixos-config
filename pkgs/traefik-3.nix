{ pkgs
, ...
}:
pkgs.buildGoModule rec {
  pname = "traefik-3";
  version = "3.0.0-beta3";

  src = pkgs.fetchzip {
    url = "https://github.com/traefik/traefik/releases/download/v${version}/traefik-v${version}.src.tar.gz";
    sha256 = "sha256-1YAZs1eMAhea+Mb8NlGe8PQnrJa6ltxdY6ZTx74YP6I=";
    stripRoot = false;
  };

  vendorSha256 = "sha256-6Au597l0Jl2ZMGOprUwtXwMLHv50r+G+4os0ECJip6A=";

  subPackages = [ "cmd/traefik" ];

  nativeBuildInputs = [ pkgs.go-bindata ];

  preBuild = ''
    go generate
    CODENAME=$(awk -F "=" '/CODENAME=/ { print $2}' script/binary)
    buildFlagsArray+=("-ldflags=\
      -X github.com/traefik/traefik/v2/pkg/version.Version=${version} \
      -X github.com/traefik/traefik/v2/pkg/version.Codename=$CODENAME")
  '';

  doCheck = false;
}

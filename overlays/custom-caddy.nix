{ pkgs, ... }:
let
  inherit (pkgs)
    buildGoModule
    cacert
    caddy
    go
    lib
    stdenv
    xcaddy
    ;
in
caddy.override {
  buildGoModule =
    args:
    buildGoModule (
      args
      // {
        src = stdenv.mkDerivation rec {
          pname = "caddy-using-xcaddy-${xcaddy.version}";
          inherit (caddy) version;

          dontUnpack = true;
          dontFixup = true;

          nativeBuildInputs = [
            cacert
            go
          ];

          plugins = [ "github.com/caddy-dns/digitalocean" ];

          configurePhase = ''
            export GOCACHE=$TMPDIR/go-cache
            export GOPATH="$TMPDIR/go"
            export XCADDY_SKIP_BUILD=1
          '';

          buildPhase = ''
            ${xcaddy}/bin/xcaddy build "${caddy.src.rev}" ${
              lib.concatMapStringsSep " " (plugin: "--with ${plugin}") plugins
            }
            cd buildenv*
            go mod vendor
          '';

          installPhase = ''
            cp -r --reflink=auto . $out
          '';

          outputHash = "sha256-k4Lu9QKShVEhVuvGEPv3KspcsmjQmPUo0jWHhXOlofQ=";
          outputHashMode = "recursive";
        };

        subPackages = [ "." ];
        ldflags = [
          "-s"
          "-w"
        ]; # # don't include version info twice
        vendorHash = null;
      }
    );
}

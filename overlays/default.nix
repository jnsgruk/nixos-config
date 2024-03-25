{ inputs, ... }: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs { pkgs = final; };

  modifications = _final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: rec {
    unstable = import inputs.unstable {
      inherit (final) system;
      config.allowUnfree = true;

      overlays = [
        (
          _final: prev: {
            traefik = prev.callPackage "${prev.path}/pkgs/servers/traefik" {
              buildGoModule = args: prev.buildGo122Module (args // rec {
                version = "3.0.0-rc1";
                src = prev.fetchzip {
                  url = "https://github.com/traefik/traefik/releases/download/v${version}/traefik-v${version}.src.tar.gz";
                  sha256 = "sha256-IQOABrwA+39WFnjmWkzl7PFwsXZrQIv8lBu+yZWSlvg=";
                  stripRoot = false;
                };
                vendorHash = "sha256-CfS3AWNz69U1J9yDwxXu2jlpvit/JdKPqn9fqo3o6W8=";

                preBuild = ''
                  GOOS= GOARCH= CGO_ENABLED=0 go generate

                  CODENAME=$(grep -Po "CODENAME := \K.+$" Makefile)

                  buildFlagsArray+=("-ldflags= -s -w \
                    -X github.com/traefik/traefik/v${prev.lib.versions.major version}/pkg/version.Version=${version} \
                    -X github.com/traefik/traefik/v${prev.lib.versions.major version}/pkg/version.Codename=$CODENAME")
                '';
              });
            };
          }
        )
      ];
    };
  };
}

{ inputs, ... }: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs { pkgs = final; };

  modifications = _final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });

    # https://github.com/NixOS/nixpkgs/pull/282595
    # https://github.com/NixOS/nixpkgs/pull/285883
    # https://github.com/NixOS/nixpkgs/issues/282749
    obsidian = prev.obsidian.overrideAttrs (oldAttrs: rec {
      installPhase = ''
        runHook preInstall
        mkdir -p $out/bin
        makeWrapper ${prev.electron_25}/bin/electron $out/bin/obsidian \
          --set LD_LIBRARY_PATH "${prev.lib.makeLibraryPath [ prev.libGL ]}" \
          --add-flags $out/share/obsidian/app.asar \
          --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform=wayland}}"
        install -m 444 -D resources/app.asar $out/share/obsidian/app.asar
        install -m 444 -D resources/obsidian.asar $out/share/obsidian/obsidian.asar
        install -m 444 -D "${oldAttrs.desktopItem}/share/applications/"* \
          -t $out/share/applications/
        for size in 16 24 32 48 64 128 256 512; do
          mkdir -p $out/share/icons/hicolor/"$size"x"$size"/apps
          convert -background none -resize "$size"x"$size" ${oldAttrs.icon} $out/share/icons/hicolor/"$size"x"$size"/apps/obsidian.png
        done
        runHook postInstall
      '';
    });
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: prev: rec {
    unstable = import inputs.unstable {
      inherit (final) system;
      config.allowUnfree = true;
    };

    homepage-dashboard-patched = prev.homepage-dashboard.overrideAttrs (oldAttrs: rec {
      patches = [
        (prev.fetchpatch {
          url = "https://raw.githubusercontent.com/jnsgruk/nixpkgs/11ddbae1c3463f317a1b35c4bd45b8e59e614602/pkgs/servers/homepage-dashboard/no-log-file.patch";
          sha256 = "sha256-MHTStCtbmljc5zTgFmZ0GbD94xbfYLO2j4Ut67ubpqs=";
        })
      ];
    });

    traefik-3 = unstable.callPackage "${unstable.path}/pkgs/servers/traefik" {
      buildGoModule = args: unstable.buildGo122Module (args // rec {
        version = "3.0.0-rc1";
        src = unstable.fetchzip {
          url = "https://github.com/traefik/traefik/releases/download/v${version}/traefik-v${version}.src.tar.gz";
          sha256 = "sha256-IQOABrwA+39WFnjmWkzl7PFwsXZrQIv8lBu+yZWSlvg=";
          stripRoot = false;
        };
        vendorHash = "sha256-CfS3AWNz69U1J9yDwxXu2jlpvit/JdKPqn9fqo3o6W8=";

        preBuild = ''
          GOOS= GOARCH= CGO_ENABLED=0 go generate

          CODENAME=$(grep -Po "CODENAME := \K.+$" Makefile)

          buildFlagsArray+=("-ldflags= -s -w \
            -X github.com/traefik/traefik/v${unstable.lib.versions.major version}/pkg/version.Version=${version} \
            -X github.com/traefik/traefik/v${unstable.lib.versions.major version}/pkg/version.Codename=$CODENAME")
        '';
      });
    };
  };
}

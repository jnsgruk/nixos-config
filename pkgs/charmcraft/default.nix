{
  pkgs,
  lib,
  ...
}: let
  pname = "charmcraft";
  version = "2.2.0";

  overlay = pkgs.python3.override {
    packageOverrides = self: super: {
      pydantic = super.pydantic.overridePythonAttrs (old: rec {
        pname = "pydantic";
        version = "1.9.0";
        src = pkgs.fetchFromGitHub {
          owner = "samuelcolvin";
          repo = pname;
          rev = "refs/tags/v${version}";
          sha256 = "sha256-C4WP8tiMRFmkDkQRrvP3yOSM2zN8pHJmX9cdANIckpM=";
        };
      });
    };
  };

  snap-helpers = pkgs.callPackage ./deps/snap-helpers.nix {};
  overrides = pkgs.callPackage ./deps/overrides.nix {};
  pydantic-yaml = pkgs.callPackage ./deps/pydantic-yaml.nix {pydantic = overlay.pkgs.pydantic;};

  craft-cli = pkgs.callPackage ./deps/craft-cli.nix {pydantic = overlay.pkgs.pydantic;};
  craft-providers = pkgs.callPackage ./deps/craft-providers {pydantic = overlay.pkgs.pydantic;};

  craft-parts = pkgs.callPackage ./deps/craft-parts.nix {
    overrides = overrides;
    pydantic = overlay.pkgs.pydantic;
    pydantic-yaml = pydantic-yaml;
  };

  craft-store = pkgs.callPackage ./deps/craft-store {
    pydantic = overlay.pkgs.pydantic;
    overrides = overrides;
  };
in
  pkgs.python3Packages.buildPythonApplication {
    pname = pname;
    version = version;

    src = pkgs.fetchFromGitHub {
      owner = "canonical";
      repo = "charmcraft";
      rev = version;
      sha256 = "sha256-D5G0CLLmrlVvqfA2sjuRtHX3BcfRj8w5boOlXz95ZGg=";
    };

    patches = [./remove-cryptography-charmcraft.patch];

    propagatedBuildInputs =
      [
        craft-cli
        craft-parts
        craft-providers
        craft-store
        overlay.pkgs.pydantic
        snap-helpers
      ]
      ++ (with pkgs.python3Packages; [
        humanize
        jinja2
        jsonschema
        python-dateutil
        pyyaml
        requests
        requests-toolbelt
        requests-unixsocket
        setuptools-rust
        tabulate
      ]);

    # TODO: Try to make the tests pass and remove this.
    doCheck = false;
    # checkInputs = with pkgs.python3Packages; [
    #   pytest
    #   pytest-runner
    #   responses
    # ];

    meta = with lib; {
      description = "Build and publish Charmed Operators";
      homepage = "https://github.com/canonical/charmcraft";
      license = licenses.lgpl3;
      maintainers = with maintainers; [jnsgruk];
    };
  }

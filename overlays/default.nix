{ inputs, ... }:
{
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs { pkgs = final; };

  modifications = _final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });

    juju4 = prev.buildGo122Module {
      pname = "juju4";
      version = "4.0-unstable-2024-07-25";

      src = prev.fetchFromGitHub {
        owner = "juju";
        repo = "juju";
        rev = "32595332427ad5d24e60794dea074a1a03472775";
        hash = "sha256-tGlVnjAiwOPgZiJ19P3DKnMfvSzGP0e/F4y+/K9Xlc0=";
      };

      vendorHash = "sha256-viXALaiAFLKAYVfmLraL0uncEIJq4a9Tdgo4u5cdsCA=";

      subPackages = [ "cmd/juju" ];

      nativeBuildInputs = [ prev.installShellFiles ];

      doCheck = false;

      postInstall = ''
        for file in etc/bash_completion.d/*; do
          installShellCompletion --bash "$file"
        done

        mv $out/bin/juju $out/bin/juju4
      '';
    };
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.unstable {
      inherit (final) system;
      config.allowUnfree = true;
      overlays = [
        (_final: prev: {
          # example = prev.example.overrideAttrs (oldAttrs: rec {
          # ...
          # });
          custom-caddy = import ./custom-caddy.nix { pkgs = prev; };
        })
      ];
    };
  };
}

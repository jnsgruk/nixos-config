{ inputs, ... }:
{
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs { pkgs = final; };

  modifications = _final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });

    juju = prev.buildGo122Module {
      pname = "juju";
      version = "4.0-beta";

      src = prev.fetchFromGitHub {
        owner = "juju";
        repo = "juju";
        rev = "dfee8e90c86bcfb05ffe187175e3dde7b8dcb599";
        hash = "sha256-UhBq04T/vjxHth1o8ywnltghUtmvZ3uJd/9ju9Oo0rg=";
      };

      vendorHash = "sha256-7wEHPICUCGAQYqHcB7Y/n8pojGoPLzNSZAuh7DqR38Y=";

      subPackages = [ "cmd/juju" ];

      nativeBuildInputs = [ prev.installShellFiles ];

      doCheck = false;

      postInstall = ''
        for file in etc/bash_completion.d/*; do
          installShellCompletion --bash "$file"
        done
      '';
    };
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: rec {
    unstable = import inputs.unstable {
      inherit (final) system;
      config.allowUnfree = true;
      overlays = [ (_final: _prev: { }) ];
    };
  };
}

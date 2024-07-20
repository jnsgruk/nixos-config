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
        rev = "e291d1ef951bcd2f871a2a72302c0314f52a2953";
        hash = "sha256-LnKLRtSya7kK/PZ+l2IESG45FaJwR/IRTlCsUrVXDEE=";
      };

      vendorHash = "sha256-EkhPY9f3w/E2L1tCoy4XVFqmW9FQpVhofKxK9UgopjM=";

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

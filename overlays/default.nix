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
      version = "4.0-beta";

      src = prev.fetchFromGitHub {
        owner = "juju";
        repo = "juju";
        rev = "e03b3da713296e9e787c118de314e024fa67f612";
        hash = "sha256-/DonloifB6BZzqPRTZlvwockuwF7NvPyLhIN1jkzc3s=";
      };

      vendorHash = "sha256-dagcCpSO0OJaajzsQt46bQQ7oEqDAMQoNUTrjLKiPR4=";

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
  unstable-packages = final: _prev: rec {
    unstable = import inputs.unstable {
      inherit (final) system;
      config.allowUnfree = true;
      overlays = [ (_final: _prev: { }) ];
    };
  };
}

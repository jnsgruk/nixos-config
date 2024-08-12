{ inputs, ... }:
{
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs { pkgs = final; };

  modifications = _final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
    juju4 = import ./juju4.nix { pkgs = prev; };

    yubihsm-shell = prev.yubihsm-shell.overrideAttrs (oldAttrs: {
      buildInputs = [
        prev.libusb1
        prev.libedit
        prev.curl
        prev.openssl
        prev.pcsclite.dev
      ];
      buildPhase = ''
        NIX_CFLAGS_COMPILE="$(pkg-config --cflags libpcsclite) $NIX_CFLAGS_COMPILE"
        runHook buildPhase
      '';
    });
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

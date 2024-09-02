{ inputs, ... }:
{
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs { pkgs = final; };

  modifications = _final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
    juju4 = import ./juju4.nix { pkgs = prev; };

    # Can be removed once https://github.com/NixOS/nixpkgs/pull/338960 is in unstable.
    swaylock-effects = prev.swaylock-effects.overrideAttrs (_: {
      depsBuildBuild = [ prev.pkg-config ];
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

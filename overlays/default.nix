{ inputs, ... }:
{
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs { pkgs = final; };

  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
    custom-caddy = import ./custom-caddy.nix { pkgs = prev; };
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    master = import inputs.master {
      inherit (final) system;
      config.allowUnfree = true;
      overlays = [
        (_final: prev: {
          # example = prev.example.overrideAttrs (oldAttrs: rec {
          # ...
          # });
        })
      ];
    };
    unstable = import inputs.unstable {
      inherit (final) system;
      config.allowUnfree = true;
      overlays = [
        (_final: prev: {
          # example = prev.example.overrideAttrs (oldAttrs: rec {
          # ...
          # });
        })
      ];
    };
  };
}

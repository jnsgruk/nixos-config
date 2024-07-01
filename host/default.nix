{
  config,
  desktop,
  hostname,
  inputs,
  lib,
  modulesPath,
  outputs,
  stateVersion,
  username,
  ...
}:
{

  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
      (./. + "/${hostname}/boot.nix")
      (./. + "/${hostname}/hardware.nix")

      ./common/base
      ./common/users/${username}
    ]
    ++ lib.optional (builtins.pathExists (./. + "/${hostname}/extra.nix")) ./${hostname}/extra.nix
    # Include desktop config if a desktop is defined
    ++ lib.optional (builtins.isString desktop) ./common/desktop;

  nixpkgs = {
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default
      inputs.agenix.overlays.default
      inputs.flypi.overlay
      inputs.hyprland.overlays.default
      inputs.libations.overlays.default

      # Or just specify overlays directly here, for example:
      # (_: _: { embr = inputs.embr.packages."${pkgs.system}".embr; })
    ];

    config = {
      allowUnfree = true;
      joypixels.acceptLicense = true;
    };
  };

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mkForce (lib.mapAttrs (_: value: { flake = value; }) inputs);

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mkForce (
      lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry
    );

    optimise.automatic = true;
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  system = {
    inherit stateVersion;
  };
}

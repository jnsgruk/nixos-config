{ pkgs, inputs, lib, options, ... }: {
  # imports = [ "${inputs.nixpkgs-unstable}/nixos/modules/virtualisation/multipass.nix" ];

  # Enable multipass, tracking the unstable pkg
  virtualisation.multipass = {
    package = pkgs.unstable.multipass;
    enable = true;
  };
}


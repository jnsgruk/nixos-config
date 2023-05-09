{ pkgs, inputs, options, ... }: {
  # Always use the multipass module from the nixos-unstable nixpkgs branch
  imports = [ "${inputs.nixpkgs-unstable}/nixos/modules/virtualisation/multipass.nix" ];

  # Enable multipass, tracking the unstable pkg
  virtualisation.multipass = {
    package = pkgs.unstable.multipass;
    enable = true;
  };
}

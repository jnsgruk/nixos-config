{ pkgs, inputs, lib, options, ... }: {
  # Enable multipass, tracking the unstable pkg
  virtualisation.multipass = {
    package = pkgs.unstable.multipass;
    enable = true;
  };
}


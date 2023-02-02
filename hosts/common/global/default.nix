{
  pkgs,
  outputs,
  ...
}: {
  imports = [
    ./locale.nix
    ./tailscale.nix
    ./openssh.nix
    ./packages.nix
  ];

  console = {
    earlySetup = true;
    font = "ter-powerline-v32n";
    packages = [pkgs.terminus_font pkgs.powerline-fonts];
    keyMap = "uk";
  };

  networking = {
    networkmanager = {
      enable = true;
      wifi = {
        backend = "iwd";
      };
    };
  };

  # Workaround for https://github.com/NixOS/nixpkgs/issues/180175
  systemd.services.NetworkManager-wait-online.enable = false;

  services.chrony.enable = true;

  nix = {
    gc = {
      automatic = true;
      options = "-d";
    };
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  nixpkgs = {
    overlays = [outputs.overlays.modifications outputs.overlays.additions];
    config = {
      allowUnfree = true;
    };
  };
}

{
  pkgs,
  outputs,
  ...
}: {
  imports = [
    ./gnupg.nix
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
    firewall.enable = true;
  };

  services.chrony.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs = {
    overlays = [outputs.overlays.modifications outputs.overlays.additions];
    config = {
      allowUnfree = true;
    };
  };
}

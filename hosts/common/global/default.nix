{ pkgs, ... }: {

  imports = [
    ./locale.nix
    ./tailscale.nix
    ./openssh.nix
    ./packages.nix
  ];

  console = {
    earlySetup = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-132n.psf.gz";
    packages = [ pkgs.terminus_font ];
    keyMap = "uk";
  };

  networking = {
    networkmanager.enable = true;
    firewall.enable = true;
  };

  services.chrony.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
}

{ hostname
, pkgs
, lib
, ...
}:
let
  # Break these packages out so they can be imported elsewhere as a common set
  # of baseline packages. Useful for installations that are home-manager-only
  # on other OSs, rather than NixOS.
  basePackages = (import ./packages.nix { inherit pkgs; }).basePackages;
in
{
  imports = [
    ./locale.nix

    ../services/firewall.nix
    ../services/networkmanager.nix
    ../services/openssh.nix
    ../services/swapfile.nix
    ../services/tailscale.nix
  ];

  networking = {
    hostName = hostname;
    useDHCP = lib.mkDefault true;
  };

  environment.systemPackages = basePackages;

  programs = {
    zsh.enable = true;
    _1password.enable = true;
  };

  services = {
    chrony.enable = true;
    journald.extraConfig = "SystemMaxUse=250M";
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };
}

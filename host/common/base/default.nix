{ hostname
, pkgs
, lib
, username
, ...
}:
let
  # Break these packages out so they can be imported elsewhere as a common set
  # of baseline packages. Useful for installations that are home-manager-only
  # on other OSs, rather than NixOS.
  inherit ((import ./packages.nix { inherit pkgs; })) basePackages;
in
{
  imports = [
    ./boot.nix
    ./console.nix
    ./locale.nix

    ../services/avahi.nix
    ../services/firewall.nix
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

  # Create dirs for home-manager
  systemd.tmpfiles.rules = [
    "d /nix/var/nix/profiles/per-user/${username} 0755 ${username} root"
  ];
}

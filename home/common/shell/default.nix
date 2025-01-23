{ pkgs, self, ... }:
let
  theme = import "${self}/lib/theme" { inherit pkgs; };
in
{
  imports = [
    ./atuin.nix
    ./bat.nix
    ./bottom.nix
    ./fastfetch.nix
    ./fzf.nix
    ./git.nix
    ./helix.nix
    ./starship.nix
    ./xdg.nix
    ./zellij.nix
    ./fish.nix
  ];

  catppuccin = {
    inherit (theme.catppuccin) flavor;
    inherit (theme.catppuccin) accent;
  };

  programs = {
    eza.enable = true;
    git.enable = true;
    gpg.enable = true;
    home-manager.enable = true;
    jq.enable = true;
  };

  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
  };

  home.packages = with pkgs; [
    age
    sops
  ];
}

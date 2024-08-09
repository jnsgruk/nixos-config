{ pkgs, self, ... }:
let
  theme = import "${self}/lib/theme" { inherit pkgs; };
in
{
  imports = [
    ./atuin.nix
    ./bat.nix
    ./bottom.nix
    ./fzf.nix
    ./git.nix
    ./fastfetch.nix
    ./starship.nix
    ./tmux.nix
    ./vim.nix
    ./xdg.nix
    ./zsh.nix
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

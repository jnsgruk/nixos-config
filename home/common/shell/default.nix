{ pkgs
, ...
}: {
  imports = [
    ./bat.nix
    ./fzf.nix
    ./git.nix
    ./htop.nix
    ./neofetch.nix
    ./starship.nix
    ./tmux.nix
    ./vim.nix
    ./xdg.nix
    ./zsh.nix
  ];

  programs = {
    exa.enable = true;
    git.enable = true;
    gpg.enable = true;
    home-manager.enable = true;
    jq.enable = true;
  };

  home.packages = with pkgs; [ ];
}

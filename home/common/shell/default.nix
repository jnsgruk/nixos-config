{ inputs
, pkgs
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
    inputs.vscode-server.nixosModules.home
  ];

  programs = {
    exa.enable = true;
    git.enable = true;
    home-manager.enable = true;
    jq.enable = true;
  };

  services = {
    # Following install, you may need to run:
    # systemctl --user enable auto-fix-vscode-server.service
    # systemctl --user start auto-fix-vscode-server.service
    vscode-server.enable = true;
  };

  home.packages = with pkgs; [ ];
}

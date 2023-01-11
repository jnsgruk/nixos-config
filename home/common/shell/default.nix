{ inputs, pkgs, ... }: {
  imports = [
    ./starship.nix
    ./tmux.nix
    ./zsh.nix
    inputs.vscode-server.nixosModules.home
  ];

  programs = {
    bat = {
      enable = true;
      themes = {
        Catppuccin-macchiato = builtins.readFile (pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "bat";
          rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
          sha256 = "sha256-6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
        } + "/Catppuccin-macchiato.tmTheme");
      };
    };
    exa.enable = true;
    git.enable = true;
    jq.enable = true;
    ssh.enable = true;
  };

  home.packages = with pkgs; [
    duf
    git-crypt
    yq-go
  ];

  # Following install, you may need to run:
  # systemctl --user enable auto-fix-vscode-server.service
  # systemctl --user start auto-fix-vscode-server.service
  services.vscode-server.enable = true;
}

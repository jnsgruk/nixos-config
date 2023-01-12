{pkgs}: {
  imports = [
    ./alacritty.nix
    ./gtk.nix
    ./vscode.nix
    ./xdg.nix
  ];

  programs.firefox.enable = true;

  home.packages = with pkgs; [
    _1password-gui
    google-chrome
    libnotify
    obsidian
    rambox
    signal-desktop
    xdg-utils
  ];
}

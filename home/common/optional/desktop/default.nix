{ pkgs, ... }: {
  imports = [
    ./alacritty.nix
    ./gtk.nix
    ./neofetch
    ./vscode.nix
    ./xdg-mime-apps.nix
    ./zathura.nix
  ];

  programs = {
    firefox.enable = true;
    mpv.enable = true;
    feh.enable = true;
  };

  home.packages = with pkgs; [
    catppuccin-gtk
    desktop-file-utils
    google-chrome
    imlib2Full
    libnotify
    obsidian
    pamixer
    pavucontrol
    rambox
    signal-desktop
    sublime-merge
    xdg-utils
    xorg.xlsclients
  ];
}

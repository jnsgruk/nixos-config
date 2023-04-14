{ pkgs, desktop, ... }: {
  imports = [
    (./. + "/${desktop}")

    ./dev

    ./alacritty.nix
    ./gtk.nix
    ./vscode.nix
    ./xdg.nix
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

  fonts.fontconfig.enable = true;
}

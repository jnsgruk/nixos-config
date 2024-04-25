{ pkgs, desktop, ... }:
{
  imports = [
    (./. + "/${desktop}")

    ../dev

    ./alacritty.nix
    ./gtk.nix
    ./qt.nix
    ./xdg.nix
    ./zathura.nix
  ];

  programs = {
    firefox.enable = true;
    mpv.enable = true;
  };

  home.packages = with pkgs; [
    audacity
    bambu-studio
    catppuccin-gtk
    desktop-file-utils
    ght
    # Workaround https://github.com/NixOS/nixpkgs/issues/306010
    (google-chrome.override {
      commandLineArgs = [
        "--enable-features=UseOzonePlatform"
        "--ozone-platform=wayland"
      ];
    })
    libnotify
    loupe
    mumble
    obsidian
    pamixer
    pavucontrol
    rambox
    signal-desktop
    todoist-electron
    xdg-utils
    xorg.xlsclients
  ];

  fonts.fontconfig.enable = true;
}

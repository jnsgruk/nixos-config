{ pkgs, desktop, ... }:
{
  imports = [
    (./. + "/${desktop}")

    ../dev

    ./ghostty.nix
    ./gtk.nix
    ./qt.nix
    ./xdg.nix
  ];

  programs = {
    firefox.enable = true;
    mpv.enable = true;
  };

  home.packages = with pkgs; [
    bambu-studio
    catppuccin-gtk
    desktop-file-utils
    ght
    google-chrome
    # (google-chrome.override {
    #   commandLineArgs = [
    #     "--enable-features=VaapiVideoDecoder,VaapiIgnoreDriverChecks,Vulkan,DefaultANGLEVulkan,VulkanFromANGLE"
    #     "--ignore-gpu-blocklist"
    #     "--enable-zero-copy"
    #   ];
    # })
    libnotify
    loupe
    papers
    pwvucontrol
    thunderbird-latest
    todoist-electron
    xdg-utils

    unstable.obsidian
    unstable.rambox
    unstable.signal-desktop
  ];

  fonts.fontconfig.enable = true;
}

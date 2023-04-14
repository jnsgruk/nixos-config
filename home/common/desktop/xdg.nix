{ ... }:
let
  browser = [ "google-chrome.desktop" ];

  # XDG MIME types
  associations = {
    "application/x-extension-htm" = browser;
    "application/x-extension-html" = browser;
    "application/x-extension-shtml" = browser;
    "application/x-extension-xht" = browser;
    "application/x-extension-xhtml" = browser;
    "application/xhtml+xml" = browser;
    "text/html" = browser;
    "x-scheme-handler/about" = browser;
    "x-scheme-handler/chrome" = browser;
    "x-scheme-handler/ftp" = browser;
    "x-scheme-handler/http" = browser;
    "x-scheme-handler/https" = browser;
    "x-scheme-handler/unknown" = browser;

    "audio/*" = [ "mpv.desktop" ];
    "video/*" = [ "mpv.dekstop" ];
    "image/*" = [ "feh.desktop" ];
    "application/json" = browser;
    "application/pdf" = [ "org.pwmt.zathura.desktop.desktop" ];
  };
in
{
  xdg = {
    enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = associations;
    };

    desktopEntries = {
      rambox = {
        name = "Rambox";
        exec = "rambox --ozone-platform-hint=auto --enable-features=UseOzonePlatform";
        terminal = false;
        icon = "rambox";
        type = "Application";
        categories = [ "Network" "Application" ];
      };

      # Override the desktop file for Nautilus to use GTK_THEME.
      # Later versions of Nautilus rely on libadwaita, which doesn't respect the GTK config
      "org.gnome.Nautilus" = {
        name = "Files";
        exec = "env GTK_THEME=Catppuccin-Macchiato-Standard-Blue-Dark nautilus --new-window";
        terminal = false;
        icon = "org.gnome.Nautilus";
        type = "Application";
        categories = [ "GNOME" "Utility" "Core" "FileManager" ];
        startupNotify = true;
        settings = {
          DBusActivatable = "true";
          X-GNOME-UsesNotifications = "true";
        };
        mimeType = [
          "inode/directory"
          "application/x-7z-compressed"
          "application/x-7z-compressed-tar"
          "application/x-bzip"
          "application/x-bzip-compressed-tar"
          "application/x-compress"
          "application/x-compressed-tar"
          "application/x-cpio"
          "application/x-gzip"
          "application/x-lha"
          "application/x-lzip"
          "application/x-lzip-compressed-tar"
          "application/x-lzma"
          "application/x-lzma-compressed-tar"
          "application/x-tar"
          "application/x-tarz"
          "application/x-xar"
          "application/x-xz"
          "application/x-xz-compressed-tar"
          "application/zip"
          "application/gzip"
          "application/bzip2"
          "application/vnd.rar"
        ];
      };
    };
  };
}



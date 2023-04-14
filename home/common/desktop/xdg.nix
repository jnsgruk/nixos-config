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
    };
  };
}


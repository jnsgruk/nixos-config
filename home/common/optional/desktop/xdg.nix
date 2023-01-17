{config, ...}: let
  browser = ["google-chrome.desktop"];

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

    "audio/*" = ["mpv.desktop"];
    "video/*" = ["mpv.dekstop"];
    "image/*" = ["feh.desktop"];
    "application/json" = browser;
    "application/pdf" = ["org.pwmt.zathura.desktop.desktop"];
  };
in {
  xdg = {
    enable = true;
    cacheHome = config.home.homeDirectory + "/.local/cache";

    mimeApps = {
      enable = true;
      defaultApplications = associations;
    };

    userDirs = {
      enable = true;
      createDirectories = true;
      extraConfig = {
        XDG_DESKTOP_DIR = "${config.home.homeDirectory}/";
        XDG_DOCUMENTS_DIR = "${config.home.homeDirectory}/";
        XDG_DOWNLOAD_DIR = "${config.home.homeDirectory}/downloads";
        XDG_MUSIC_DIR = "${config.home.homeDirectory}/";
        XDG_PICTURES_DIR = "${config.home.homeDirectory}/pictures";
        XDG_PUBLICSHARE_DIR = "${config.home.homeDirectory}/";
        XDG_TEMPLATES_DIR = "${config.home.homeDirectory}/";
        XDG_VIDEOS_DIR = "${config.home.homeDirectory}/";
        XDG_CONFIG_HOME = "${config.home.homeDirectory}/.config";
        XDG_SCREENSHOTS_DIR = "${config.home.homeDirectory}/pictures/screenshots";
      };
    };
  };
}

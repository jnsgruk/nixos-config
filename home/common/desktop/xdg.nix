{ pkgs, lib, ... }:
let
  theme = import ../../../lib/theme { inherit pkgs; };
  inherit ((import ./file-associations.nix)) associations;
in
{
  xdg = {
    enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = associations;
    };

    desktopEntries = {
      # This is obviously brittle, but works around some difficulties in the (current)
      # distribution model of the Cider beta, where they drop binaries onto itch.io.
      cider = {
        name = "Cider";
        exec = "${pkgs.appimage-run}/bin/appimage-run -- /home/jon/data/apps/Cider.AppImage";
        terminal = false;
        icon = "cider";
        type = "Application";
        categories = [ "Audio" "Application" ];
      };

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
        exec = "env GTK_THEME=${theme.gtkTheme.name} nautilus --new-window";
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
      # Override the desktop file for Loupe to use GTK_THEME.
      # Later versions of Nautilus rely on libadwaita, which doesn't respect the GTK config
      "org.gnome.Loupe.desktop" = {
        name = "Loupe";
        exec = "env GTK_THEME=${theme.gtkTheme.name} loupe %U";
        terminal = false;
        icon = "org.gnome.Loupe";
        type = "Application";
        categories = [ "GNOME" "GTK" "Graphics" "2DGraphics" "RasterGraphics" "Viewer" ];
        startupNotify = true;
        settings = {
          DBusActivatable = "true";
        };
        mimeType = [
          "image/jpeg"
          "image/png"
          "image/gif"
          "image/webp"
          "image/tiff"
          "image/x-tga"
          "image/vnd-ms.dds"
          "image/x-dds"
          "image/bmp"
          "image/vnd.microsoft.icon"
          "image/vnd.radiance"
          "image/x-exr"
          "image/x-portable-bitmap"
          "image/x-portable-graymap"
          "image/x-portable-pixmap"
          "image/x-portable-anymap"
          "image/x-qoi"
          "image/svg+xml"
          "image/svg+xml-compressed"
          "image/avif"
          "image/heic"
          "image/jxl"
        ];
      };
    };
  };
}



{ pkgs, config, ... }:
let
  theme = (import ../../../home/common/optional/desktop/gtk.nix { inherit pkgs config; }).theme;
in
{
  environment.systemPackages = with pkgs; [
    (gnome.nautilus.overrideAttrs (_old: {
      # Patch the .desktop file for Nautilus to force the GTK_THEME variable.
      # Later versions of Nautilus rely on libadwaita, which doesn't seem to respect the
      # gtk-theme-name in the gtk config.
      postInstall = ''
        sed -i -e \
          "s/Exec=/Exec=env GTK_THEME=${theme} /g" \
          $out/share/applications/org.gnome.Nautilus.desktop
      '';
    }))
  ];

  programs = {
    # Archive manager
    file-roller.enable = true;
  };

  services = {
    gvfs.enable = true;
    # Enable quick preview with sushi
    gnome.sushi.enable = true;
  };
}

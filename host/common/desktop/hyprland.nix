{
  pkgs,
  lib,
  self,
  ...
}:
let
  theme = import "${self}/lib/theme" { inherit pkgs; };
  hypr-run = pkgs.writeShellScriptBin "hypr-run" ''
    export XDG_SESSION_TYPE="wayland"
    export XDG_SESSION_DESKTOP="Hyprland"
    export XDG_CURRENT_DESKTOP="Hyprland"
    export GTK_THEME=${theme.gtkTheme.name}

    systemd-run --user --scope --collect --quiet --unit="hyprland" \
        systemd-cat --identifier="hyprland" ${pkgs.hyprland}/bin/Hyprland $@

    ${pkgs.hyprland}/bin/hyperctl dispatch exit
  '';
in
{

  programs = {
    dconf.enable = true;
    file-roller.enable = true;
    hyprland.enable = true;
  };

  environment = {
    variables.NIXOS_OZONE_WL = "1";

    systemPackages = with pkgs; [
      nautilus
      zenity
      # Enable HEIC image previews in Nautilus
      libheif
      libheif.out
      polkit_gnome
    ];

    # Enable HEIC image previews in Nautilus
    pathsToLink = [ "share/thumbnailers" ];
  };

  services = {
    dbus = {
      enable = true;
      # Make the gnome keyring work properly
      packages = [
        pkgs.gnome-keyring
        pkgs.gcr
      ];
    };

    gnome = {
      gnome-keyring.enable = true;
      sushi.enable = true;
    };

    greetd = {
      enable = true;
      restart = false;
      settings = {
        default_session = {
          command = ''
            ${lib.makeBinPath [ pkgs.greetd.tuigreet ]}/tuigreet -r --asterisks --time \
              --cmd ${lib.getExe hypr-run}
          '';
        };
      };
    };

    gvfs.enable = true;
  };
}

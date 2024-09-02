{ pkgs, ... }:
{
  programs = {
    dconf.enable = true;
    file-roller.enable = true;
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
      implementation = "broker";
    };

    gnome = {
      gnome-keyring.enable = true;
      sushi.enable = true;
    };

    greetd = {
      enable = true;
      restart = false;
    };

    gvfs.enable = true;
  };
}

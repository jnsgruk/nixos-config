{ pkgs, ... }:
{
  imports = [
    ./waybar
    ./mako.nix
    ./rofi.nix
    ./swappy.nix
  ];

  services = {
    avizo.enable = true;

    cliphist = {
      enable = true;
      package = pkgs.master.cliphist;
    };

    gnome-keyring.enable = true;

    wlsunset = {
      enable = true;
      latitude = "51.51";
      longitude = "-2.53";
    };
  };

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    Unit.Description = "polkit-gnome-authentication-agent-1";
    Install.WantedBy = [ "graphical-session.target" ];
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  home.packages = with pkgs; [
    grim
    libva-utils
    playerctl
    wf-recorder
    wl-clipboard
    wdisplays
    wmctrl
  ];

  home.sessionVariables = {
    _JAVA_AWT_WM_NONREPARENTING = "1";
    CLUTTER_BACKEND = "wayland";
    GDK_BACKEND = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    # QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
  };
}

{pkgs, ...}: {
  fonts = {
    fonts = with pkgs; [
      (nerdfonts.override {fonts = ["FiraCode" "Meslo"];})
      joypixels
      liberation_ttf
      sf-mono-liga-font
      sfpro-font
      ubuntu_font_family
    ];

    # use fonts specified by user rather than default ones
    enableDefaultFonts = false;

    fontconfig.defaultFonts = {
      serif = ["SF Pro Display" "Joypixels"];
      sansSerif = ["SF Pro Display" "Joypixels"];
      monospace = ["MesloLGSDZ Nerd Font Mono" "FiraCode Nerd Font Mono"];
      emoji = ["Joypixels"];
    };
  };

  # Accept the joypixels license
  nixpkgs.config.joypixels.acceptLicense = true;

  environment = {
    variables.NIXOS_OZONE_WL = "1";

    systemPackages = with pkgs; [
      polkit_gnome
    ];
  };

  # enable location service
  location.provider = "geoclue2";

  programs = {
    # make HM-managed GTK stuff work
    dconf.enable = true;
  };

  services = {
    dbus.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      jack.enable = true;
      pulse.enable = true;
    };

    xserver.layout = "gb";
  };

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      unitConfig = {
        Description = "polkit-gnome-authentication-agent-1";
        Wants = ["graphical-session.target"];
        WantedBy = ["graphical-session.target"];
        After = ["graphical-session.target"];
      };
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  security = {
    # allow wayland lockers to unlock the screen
    pam.services.swaylock.text = "auth include login";
    # userland niceness
    rtkit.enable = true;
    # polkit
    polkit.enable = true;
  };

  xdg = {
    portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
    };
  };
}

{ desktop, pkgs, ... }: {
  imports = [
    (./. + "/${desktop}.nix")
    ../hardware/ledger.nix
    ../services/pipewire.nix
    ../virt
  ];

  # Enable Plymouth and surpress some logs by default.
  boot.plymouth.enable = true;
  boot.kernelParams = [
    # The 'splash' arg is included by the plymouth option
    "quiet"
    "loglevel=3"
    "rd.udev.log_priority=3"
    "vt.global_cursor_default=0"
  ];

  hardware.opengl.enable = true;

  # Enable location services
  location.provider = "geoclue2";

  programs = {
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = [ "jon" ];
    };

    dconf.enable = true;

    # Archive manager
    file-roller.enable = true;
  };

  fonts = {
    fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "FiraCode" "Meslo" ]; })
      joypixels
      liberation_ttf
      sf-mono-liga-font
      sfpro-font
      ubuntu_font_family
    ];

    # Use fonts specified by user rather than default ones
    enableDefaultFonts = false;

    fontconfig = {
      enable = true;
      antialias = true;

      defaultFonts = {
        serif = [ "SF Pro Display" "Joypixels" ];
        sansSerif = [ "SF Pro Display" "Joypixels" ];
        monospace = [ "MesloLGSDZ Nerd Font Mono" "FiraCode Nerd Font Mono" ];
        emoji = [ "Joypixels" ];
      };

      hinting = {
        enable = true;
        style = "hintfull";
        autohint = true;
      };

      subpixel = {
        rgba = "rgb";
        lcdfilter = "default";
      };
    };
  };

  # Accept the joypixels license
  nixpkgs.config.joypixels.acceptLicense = true;
}

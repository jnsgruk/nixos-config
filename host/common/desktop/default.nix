{ desktop, pkgs, theme, ... }: {
  imports = [
    (./. + "/${desktop}.nix")
    ../hardware/ledger.nix
    ../hardware/yubikey.nix
    ../services/networkmanager.nix
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
    packages = with pkgs; [
      liberation_ttf
      ubuntu_font_family

      theme.fonts.default.package
      theme.fonts.emoji.package
      theme.fonts.iconFont.package
      theme.fonts.monospace.package
    ];

    # Use fonts specified by user rather than default ones
    enableDefaultPackages = false;

    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "${theme.fonts.default.name}" "${theme.fonts.emoji.name}" ];
        sansSerif = [ "${theme.fonts.default.name}" "${theme.fonts.emoji.name}" ];
        monospace = [ "${theme.fonts.monospace.name}" ];
        emoji = [ "${theme.fonts.emoji.name}" ];
      };
    };
  };
}

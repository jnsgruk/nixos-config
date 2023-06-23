{ desktop, pkgs, theme, ... }:
let
  defaults = theme { inherit pkgs; };
in
{
  imports = [
    (./. + "/${desktop}.nix")
    ../hardware/ledger.nix
    ../hardware/yubikey.nix
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
      liberation_ttf
      ubuntu_font_family

      defaults.fonts.default.package
      defaults.fonts.emoji.package
      defaults.fonts.iconFont.package
      defaults.fonts.monospace.package
    ];

    # Use fonts specified by user rather than default ones
    enableDefaultFonts = false;

    fontconfig = {
      enable = true;
      antialias = true;

      defaultFonts = {
        serif = [ "${defaults.fonts.default.name}" "${defaults.fonts.emoji.name}" ];
        sansSerif = [ "${defaults.fonts.default.name}" "${defaults.fonts.emoji.name}" ];
        monospace = [ "${defaults.fonts.monospace.name}" ];
        emoji = [ "${defaults.fonts.emoji.name}" ];
      };

      hinting = {
        enable = true;
        style = "full";
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

_: {
  console.keyMap = "uk";
  services.xserver.xkb.layout = "gb";

  i18n = {
    defaultLocale = "en_GB.utf8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_GB.utf8";
      LC_IDENTIFICATION = "en_GB.utf8";
      LC_MEASUREMENT = "en_GB.utf8";
      LC_MONETARY = "en_GB.utf8";
      LC_NAME = "en_GB.utf8";
      LC_NUMERIC = "en_GB.utf8";
      LC_PAPER = "en_GB.utf8";
      LC_TELEPHONE = "en_GB.utf8";
      LC_TIME = "en_GB.utf8";
    };
  };

  location.provider = "geoclue2";

  services = {
    automatic-timezoned.enable = true;
    geoclue2 = {
      enable = true;
      # https://github.com/NixOS/nixpkgs/issues/321121
      geoProviderUrl = "https://beacondb.net/v1/geolocate";
      submissionNick = "jnsgr.uk";
      submissionUrl = "https://beacondb.net/v2/geosubmit";
      submitData = true;
    };
    localtimed.enable = true;
  };

  time.hardwareClockInLocalTime = true;
}

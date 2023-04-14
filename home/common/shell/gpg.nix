{ ... }: {
  programs = {
    gpg = {
      enable = true;
      scdaemonSettings = {
        disable-ccid = true;
      };
    };
  };

  services = {
    gpg-agent = {
      enable = true;
      enableSshSupport = true;
      pinentryFlavor = "qt";
    };
  };
}

{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    yubikey-manager
    pinentry-curses
  ];

  services = {
    pcscd.enable = true;
    udev.packages = [ pkgs.yubikey-personalization ];
  };

  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "qt";
  };
}

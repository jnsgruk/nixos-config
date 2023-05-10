{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    pinentry-curses
    pinentry-qt
    yubikey-manager
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

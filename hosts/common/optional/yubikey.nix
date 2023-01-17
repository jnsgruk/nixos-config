{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    yubikey-manager
  ];

  services.udev.packages = [pkgs.yubikey-personalization];
  services.pcscd.enable = true;

  programs.gnupg.agent.enable = true;
}

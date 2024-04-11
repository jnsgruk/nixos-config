{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ yubikey-manager ];

  services = {
    pcscd.enable = true;
    udev.packages = [ pkgs.yubikey-personalization ];
  };
}

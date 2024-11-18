{
  lib,
  pkgs,
  desktop,
  ...
}:
{
  hardware.pulseaudio.enable = lib.mkForce false;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  environment.systemPackages = if (builtins.isString desktop) then [ pkgs.pwvucontrol ] else [ ];
}

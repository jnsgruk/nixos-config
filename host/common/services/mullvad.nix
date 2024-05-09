{ pkgs, lib, ... }:
{
  services.mullvad-vpn.enable = true;

  # By default the module enables verbose logging by default,
  # which is quite noisy. This undoes that.
  systemd.services.mullvad-daemon.serviceConfig.ExecStart = lib.mkForce "${pkgs.mullvad}/bin/mullvad-daemon --disable-stdout-timestamps";
}

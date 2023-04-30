{ pkgs, ... }: {
  services.mullvad-vpn.enable = true;
  environment.systemPackages = with pkgs; [ mullvad-vpn mullvad ];
}

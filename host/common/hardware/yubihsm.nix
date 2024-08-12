{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    yubihsm-connector
    yubihsm-shell
  ];
}

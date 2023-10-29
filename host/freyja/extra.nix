{ lib, ... }: {
  imports = [
    ../common/services/mullvad.nix
  ];

  time.timeZone = lib.mkForce "Europe/Riga";
}

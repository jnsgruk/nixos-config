{ pkgs, ... }:
{
  # Enable the udev rules for Ledger devices
  hardware.ledger.enable = true;

  # Install the ledger live desktop app globally
  environment.systemPackages = with pkgs; [ ledger-live-desktop ];

  # Needed for Ledger Live app
  users.groups.plugdev = { };
}

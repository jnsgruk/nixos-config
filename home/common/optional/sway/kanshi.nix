{hostname, ...}: {
  services = {
    kanshi = {
      enable = true;
      profiles = (import ./config/displays.nix {}).${hostname}.kanshi-profiles;
    };
  };
}

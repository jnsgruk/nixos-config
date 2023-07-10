{ desktop, ... }: {
  services = {
    avahi = {
      enable = true;
      nssmdns = true;
      publish = {
        enable = true;
        addresses = true;
        workstation = if (builtins.isString desktop) then true else false;
      };
    };
  };
}

{ desktop, hostname, ... }: {
  services = {
    avahi = {
      enable = true;
      openFirewall = true;
      nssmdns = true;
      publish = {
        enable = true;
        addresses = true;
        workstation = if (builtins.isString desktop) then true else false;
      };
    };
  };
}

{ desktop, ... }:
{
  services = {
    avahi = {
      enable = true;
      openFirewall = true;
      nssmdns4 = true;
      publish = {
        enable = true;
        addresses = true;
        workstation = if (builtins.isString desktop) then true else false;
      };
    };
  };
}

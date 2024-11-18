{ pkgs, ... }:
{
  virtualisation = {
    lxd = {
      enable = true;
      zfsSupport = true;
      ui = {
        enable = true;
        package = pkgs.lxd-ui;
      };
    };
  };

  networking = {
    firewall = {
      trustedInterfaces = [ "lxdbr0" ];
    };
  };
}

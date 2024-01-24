{ pkgs, ... }: {
  virtualisation = {
    lxd = {
      enable = true;
      zfsSupport = true;
      ui = {
        enable = true;
        package = pkgs.unstable.lxd-unwrapped.ui;
      };
    };
  };

  networking = {
    firewall = {
      trustedInterfaces = [ "lxdbr0" ];
    };
  };
}

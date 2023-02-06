{ pkgs, ... }: {
  virtualisation = {
    lxd = {
      enable = true;
      zfsSupport = true;
    };
  };

  # These kernel modules are referenced as part of the profile used to run MicroK8s on LXD
  boot.kernelModules = [
    "ip_vs"
    "ip_vs_rr"
    "ip_vs_wrr"
    "ip_vs_sh"
    "ip_tables"
    "ip6_tables"
    "netlink_diag"
    "nf_nat"
    "overlay"
    "br_netfilter"
  ];

  # Enable AppArmor, as part of enabling MicroK8s on LXD
  security.apparmor.enable = true;

  # Install the AppArmor kernel patches
  environment.systemPackages = with pkgs; [
    apparmor-kernel-patches
  ];

  systemd.services = {
    populate-lxd-profiles = {
      serviceConfig.type = "oneshot";
      after = [ "lxd.service" ];
      reloadTriggers = [ ./lxc-profiles/dev.yaml ];
      script = ''
        if ! ${pkgs.lxd}/bin/lxc profile show dev; then
          ${pkgs.lxd}/bin/lxc profile create dev
        fi
        cat ${./profile-dev.yaml} | ${pkgs.lxd}/bin/lxc profile edit dev
      '';
    };
  };
}

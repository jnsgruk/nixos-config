{pkgs, ...}: {
  virtualisation = {
    lxd = {
      enable = true;
      zfsSupport = true;
    };
  };

  security.apparmor.enable = true;

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

  environment.systemPackages = with pkgs; [apparmor-kernel-patches];
}

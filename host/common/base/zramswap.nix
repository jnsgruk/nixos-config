_: {
  # Balance lz4 latency/throughput
  boot.kernel.sysctl."vm.page-cluster" = 1;

  # Hibernate and hybrid-sleep won't work correctly without
  # an on-disk swap.
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  # Enable zramSwap
  zramSwap = {
    algorithm = "lz4";
    enable = true;
  };
}

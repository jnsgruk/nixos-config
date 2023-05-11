{ ... }: {
  imports = [
    ../common/virt/docker.nix
  ];

  # Firewall port for NFS
  networking.firewall.allowedTCPPorts = [ 2049 ];

  # Setup NFS exports
  services = {
    nfs = {
      server = {
        enable = true;
        exports = ''
          /data/media  100.64.0.0/10 (rw,fsid=0,no_subtree_check)
        '';
      };
    };
  };
}

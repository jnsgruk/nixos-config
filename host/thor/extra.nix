{ ... }: {
  imports = [
    ../common/virt/docker.nix
  ];

  # Firewall port for NFS
  networking.firewall = {
    allowedTCPPorts = [ 111 2049 4000 4001 4002 20048 ];
    allowedUDPPorts = [ 111 2049 4000 4001 4002 20048 ];
  };

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

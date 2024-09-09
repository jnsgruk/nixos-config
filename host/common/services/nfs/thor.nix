_: {
  services.nfs.server.exports = ''
    /data  100.64.0.0/10 (rw,fsid=0,no_subtree_check)
  '';
}

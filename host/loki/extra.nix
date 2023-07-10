{ lib, ... }:
let
  dataDir = "/data/apps";
in
{
  imports = [
    ../common/services/files.nix
    ../common/services/homepage.nix
    ../common/services/servarr
    ../common/services/traefik
    ../common/virt
  ];

  # Firewall port for NFS
  networking.firewall = {
    allowedTCPPorts = [ 111 2049 4000 4001 4002 20048 ];
    allowedUDPPorts = [ 111 2049 4000 4001 4002 20048 ];
  };

  services = {
    duplicati = {
      enable = true;
      dataDir = "${dataDir}/duplicati";
    };

    nfs = {
      server = {
        enable = true;
        exports = ''
          /data/media  100.64.0.0/10 (rw,fsid=0,no_subtree_check)
        '';
      };
    };

    syncthing = {
      enable = true;
      guiAddress = "100.98.152.46:8384";
      configDir = "${dataDir}/syncthing";
      user = "jon";
      group = "users";
    };

  };

  systemd.services.duplicati.serviceConfig.Group = lib.mkForce "users";
}


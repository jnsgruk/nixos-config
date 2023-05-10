{ pkgs, ... }: {
  systemd.services = {
    create-swapfile = {
      serviceConfig.type = "oneshot";
      wantedBy = [ "swap-swapfile.swap" ];
      script = ''
        swapdir="/.swap"
        swapfile="$swapdir/swapfile"
        if [[ -f "$swapfile" ]]; then
          echo "Swapfile $swapfile already exists"
        else
          ${pkgs.coreutils}/bin/mkdir "$swapdir"
          ${pkgs.coreutils}/bin/truncate -s 0 "$swapfile"
          
          if [[ "$(${pkgs.util-linux}/bin/findmnt -no FSTYPE /)" == "btrfs" ]]; then
            ${pkgs.e2fsprogs}/bin/chattr +C "$swapfile"
            ${pkgs.btrfs-progs}/bin/btrfs property set "$swapfile" compression none
          fi
        fi
      '';
    };
  };
}

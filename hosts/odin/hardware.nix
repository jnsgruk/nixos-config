{ config
, lib
, pkgs
, modulesPath
, ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/5ca1f3fa-c43b-4f10-96c2-e35643a9617d";
    fsType = "btrfs";
    options = [ "subvol=@" ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/5ca1f3fa-c43b-4f10-96c2-e35643a9617d";
    fsType = "btrfs";
    options = [ "subvol=@home" ];
  };

  fileSystems."/var" = {
    device = "/dev/disk/by-uuid/5ca1f3fa-c43b-4f10-96c2-e35643a9617d";
    fsType = "btrfs";
    options = [ "subvol=@var" ];
  };

  fileSystems."/.snapshots" = {
    device = "/dev/disk/by-uuid/5ca1f3fa-c43b-4f10-96c2-e35643a9617d";
    fsType = "btrfs";
    options = [ "subvol=@snapshots" ];
  };

  fileSystems."/.swap" = {
    device = "/dev/disk/by-uuid/5ca1f3fa-c43b-4f10-96c2-e35643a9617d";
    fsType = "btrfs";
    options = [ "subvol=@swap" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/47DA-705F";
    fsType = "vfat";
  };

  swapDevices = [{
    device = "/swap/swapfile";
    size = 2048;
  }];

  systemd.services = {
    create-swapfile = {
      serviceConfig.type = "oneshot";
      wantedBy = [ "swap-swapfile.swap" ];
      script = ''
        swapdir="/swap"
        swapfile="$swapdir/swapfile"
        if [[ -f "$swapfile" ]]; then
          echo "Swapfile $swapfile already exists"
        else
          ${pkgs.coreutils}/bin/mkdir "$swapdir"
          ${pkgs.coreutils}/bin/truncate -s 0 "$swapfile"
          ${pkgs.e2fsprogs}/bin/chattr +C "$swapfile"
          ${pkgs.btrfs-progs}/bin/btrfs property set "$swapfile" compression none
        fi
      '';
    };
  };

  # powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  services.fstrim.enable = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    video.hidpi.enable = lib.mkDefault true;
    opengl.extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium) 
    ];
    bluetooth.enable = true;
  };
}

{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/d4a77c74-240e-4b0a-9fd4-e09033cd087d";
    fsType = "btrfs";
    options = [ "subvol=@" ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/d4a77c74-240e-4b0a-9fd4-e09033cd087d";
    fsType = "btrfs";
    options = [ "subvol=@home" ];
  };

  fileSystems."/var" = {
    device = "/dev/disk/by-uuid/d4a77c74-240e-4b0a-9fd4-e09033cd087d";
    fsType = "btrfs";
    options = [ "subvol=@var" ];
  };

  fileSystems."/.snapshots" = {
    device = "/dev/disk/by-uuid/d4a77c74-240e-4b0a-9fd4-e09033cd087d";
    fsType = "btrfs";
    options = [ "subvol=@snapshots" ];
  };

  fileSystems."/.swap" = {
    device = "/dev/disk/by-uuid/d4a77c74-240e-4b0a-9fd4-e09033cd087d";
    fsType = "btrfs";
    options = [ "subvol=@swap" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/2BD9-A904";
    fsType = "vfat";
  };

  fileSystems."/home/jon/data" = {
    device = "/dev/mapper/data";
    fsType = "ext4";
  };

  environment.etc."crypttab".text = ''
    data  /dev/disk/by-uuid/a9fca2ea-2114-42df-a2a8-8638a28618ac  /etc/data.keyfile
  '';

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
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    video.hidpi.enable = lib.mkDefault true;
  };
}

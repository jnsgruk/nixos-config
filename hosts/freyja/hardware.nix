{ config
, inputs
, lib
, pkgs
, ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-z13
    ../common/optional/bluetooth.nix
  ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/99db9e90-c813-4469-a6a7-bae6b8f49955";
      fsType = "btrfs";
      options = [ "subvol=@" ];
    };

  fileSystems."/home" =
    {
      device = "/dev/disk/by-uuid/99db9e90-c813-4469-a6a7-bae6b8f49955";
      fsType = "btrfs";
      options = [ "subvol=@home" ];
    };

  fileSystems."/var" =
    {
      device = "/dev/disk/by-uuid/99db9e90-c813-4469-a6a7-bae6b8f49955";
      fsType = "btrfs";
      options = [ "subvol=@var" ];
    };

  fileSystems."/.snapshots" =
    {
      device = "/dev/disk/by-uuid/99db9e90-c813-4469-a6a7-bae6b8f49955";
      fsType = "btrfs";
      options = [ "subvol=@snapshots" ];
    };

  fileSystems."/.swap" =
    {
      device = "/dev/disk/by-uuid/99db9e90-c813-4469-a6a7-bae6b8f49955";
      fsType = "btrfs";
      options = [ "subvol=@swap" ];
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/21B1-1362";
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
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}

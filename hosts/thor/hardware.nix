{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/67e2aec0-abb8-4d0d-b8d4-556a8b2f3532";
    fsType = "btrfs";
    options = ["subvol=@" "compress=lzo" "noatime" "nodiratime" "ssd"];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/67e2aec0-abb8-4d0d-b8d4-556a8b2f3532";
    fsType = "btrfs";
    options = ["subvol=@home" "compress=lzo" "noatime" "nodiratime" "ssd"];
  };

  fileSystems."/var" = {
    device = "/dev/disk/by-uuid/67e2aec0-abb8-4d0d-b8d4-556a8b2f3532";
    fsType = "btrfs";
    options = ["subvol=@var" "compress=lzo" "noatime" "nodiratime" "ssd"];
  };

  fileSystems."/.snapshots" = {
    device = "/dev/disk/by-uuid/67e2aec0-abb8-4d0d-b8d4-556a8b2f3532";
    fsType = "btrfs";
    options = ["subvol=@snapshots" "compress=lzo" "noatime" "nodiratime" "ssd"];
  };

  fileSystems."/swap" = {
    device = "/dev/disk/by-uuid/67e2aec0-abb8-4d0d-b8d4-556a8b2f3532";
    fsType = "btrfs";
    options = ["subvol=@swap"];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/FD29-48A2";
    fsType = "vfat";
  };

  swapDevices = [
    {
      device = "/swap/swapfile";
      size = 2048;
    }
  ];

  systemd.services = {
    create-swapfile = {
      serviceConfig.type = "oneshot";
      wantedBy = ["swap-swapfile.swap"];
      script = ''
        swapfile="/swap/swapfile"
        if [[ -f "$swapfile" ]]; then
          echo "Swapfile $swapfile already exists"
        else
          ${pkgs.coreutils}/bin/truncate -s 0 "$swapfile"
          ${pkgs.e2fsprogs}/bin/chattr +C "$swapfile"
          ${pkgs.btrfs-progs}/bin/btrfs property set "$swapfile" compression none
        fi
      '';
    };
  };

  services.fstrim.enable = lib.mkDefault true;

  # TODO: Search for this; I don't know if this should be enabled or not.
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    video.hidpi.enable = lib.mkDefault true;
  };
}

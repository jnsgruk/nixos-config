{ inputs, ... }:

{
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.nixos-hardware.nixosModules.common-hidpi
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd

    ../common/hardware/bluetooth.nix
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  hardware = {
    enableAllFirmware = true;
    amdgpu.loadInInitrd = true;
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/072df22f-b9b0-4b4c-b718-26557a7c67d5";
    fsType = "btrfs";
    options = [ "subvol=@" ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/072df22f-b9b0-4b4c-b718-26557a7c67d5";
    fsType = "btrfs";
    options = [ "subvol=@home" ];
  };

  fileSystems."/var" = {
    device = "/dev/disk/by-uuid/072df22f-b9b0-4b4c-b718-26557a7c67d5";
    fsType = "btrfs";
    options = [ "subvol=@var" ];
  };

  fileSystems."/.snapshots" = {
    device = "/dev/disk/by-uuid/072df22f-b9b0-4b4c-b718-26557a7c67d5";
    fsType = "btrfs";
    options = [ "subvol=@snapshots" ];
  };

  fileSystems."/.swap" = {
    device = "/dev/disk/by-uuid/072df22f-b9b0-4b4c-b718-26557a7c67d5";
    fsType = "btrfs";
    options = [ "subvol=@swap" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/F357-87EE";
    fsType = "vfat";
  };

  fileSystems."/home/jon/data" = {
    device = "/dev/mapper/data";
    fsType = "ext4";
  };

  swapDevices = [{
    device = "/.swap/swapfile";
    size = 2048;
  }];

  environment.etc = {
    "crypttab".text = ''
      data  /dev/disk/by-uuid/a9fca2ea-2114-42df-a2a8-8638a28618ac  /etc/data.keyfile
    '';

    "wireplumber/main.lua.d/51-disable-suspension.lua".text = ''
      table.insert (alsa_monitor.rules, {
        matches = {
          {
            { "node.name", "matches", "*Audioengine*" },
          },
        },
        apply_properties = {
          ["session.suspend-timeout-seconds"] = 0,
        },
      })
    '';
  };
}

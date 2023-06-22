{ inputs, ... }:

{
  imports = [
    inputs.disko.nixosModules.disko
    (import ./disks.nix { })

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

  swapDevices = [{
    device = "/.swap/swapfile";
    size = 2048;
  }];

  environment.etc = {
    "crypttab".text = ''
      data  /dev/disk/by-partlabel/data  /etc/data.keyfile
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

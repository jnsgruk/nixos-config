{ disks ? [ "/dev/nvme0n1" "/dev/nvme1n1" ], ... }:
let
  cryptroot = "cryptroot";
  defaultBtrfsOpts = [ "defaults" "compress=zstd:1" "ssd" "noatime" "nodiratime" ];
in
{
  boot.initrd.luks.devices.${cryptroot} = {
    allowDiscards = true;
    preLVM = true;
  };

  environment.etc = {
    "crypttab".text = ''
      data  /dev/disk/by-partlabel/data  /etc/data.keyfile
    '';
  };

  disko.devices = {
    disk = {
      # 1TB root/boot drive. Configured with:
      # - A FAT32 ESP partition for systemd-boot
      # - A LUKS container which containers multiple btrfs subvolumes for nixos install
      nvme0 = {
        device = builtins.elemAt disks 0;
        type = "disk";
        content = {
          type = "table";
          format = "gpt";
          partitions = [
            {
              name = "ESP";
              start = "0%";
              end = "512MiB";
              bootable = true;
              fs-type = "fat32";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            }
            {
              name = "luks";
              start = "512MiB";
              end = "100%";
              content = {
                type = "luks";
                name = "${cryptroot}";
                extraOpenArgs = [ "--allow-discards" ];

                content = {
                  type = "btrfs";
                  # Override existing partition
                  extraArgs = [ "-f" ];
                  subvolumes = {
                    "@" = {
                      mountpoint = "/";
                      mountOptions = defaultBtrfsOpts;
                    };
                    "@nix" = {
                      mountpoint = "/nix";
                      mountOptions = defaultBtrfsOpts;
                    };
                    "@home" = {
                      mountpoint = "/home";
                      mountOptions = defaultBtrfsOpts;
                    };
                    "@var" = {
                      mountpoint = "/var";
                      mountOptions = defaultBtrfsOpts;
                    };
                    "@snapshots" = {
                      mountpoint = "/.snapshots";
                      mountOptions = defaultBtrfsOpts;
                    };
                    "@swap" = {
                      mountpoint = "/.swap";
                      mountOptions = [ "defaults" "x-mount.mkdir" "ssd" "noatime" "nodiratime" ];
                    };
                  };
                };
              };
            }
          ];
        };
      };

      # 2TB data drive. LUKS encrypted with single btrfs subvolume.
      nvme1 = {
        device = builtins.elemAt disks 1;
        type = "disk";
        content = {
          type = "table";
          format = "gpt";
          partitions = [{
            name = "data";
            start = "0%";
            end = "100%";
            content = {
              type = "luks";
              name = "data";
              extraOpenArgs = [ "--allow-discards" ];
              # Make sure there is no trailing newline in keyfile if used for interactive unlock.
              # Use `echo -n "password" > /tmp/secret.key`
              keyFile = "/tmp/data.keyfile";

              # Don't try to unlock this drive early in the boot.
              initrdUnlock = false;

              content = {
                type = "btrfs";
                # Override existing partition
                extraArgs = [ "-f" ];
                subvolumes = {
                  "@data" = {
                    mountpoint = "/home/jon/data";
                    mountOptions = defaultBtrfsOpts;
                  };
                };
              };
            };
          }];
        };
      };
    };
  };
}

{ ... }:
let
  defaultBtrfsOpts = [ "defaults" "compress=zstd:1" "ssd" "noatime" "nodiratime" ];
in
{
  environment.etc = {
    "crypttab".text = ''
      data  /dev/disk/by-partlabel/data  /etc/data.keyfile
    '';
  };

  disko.devices = {
    disk = {
      # 512GB root/boot drive. Configured with:
      # - A FAT32 ESP partition for systemd-boot
      # - Multiple btrfs subvolumes for the installation of nixos
      nvme0 = {
        device = "/dev/nvme0n1";
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
              name = "root";
              start = "512MiB";
              end = "100%";
              part-type = "primary";
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
            }
          ];
        };
      };

      # 4TB data drive. LUKS encrypted with single btrfs subvolume.
      sda = {
        device = "/dev/sda";
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
                    mountpoint = "/data";
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

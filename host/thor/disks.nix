{ lib, ... }:
let
  defaultBtrfsOpts = [ "defaults" "compress=zstd:1" "ssd" "noatime" "nodiratime" ];
in
{
  environment.etc = {
    "crypttab".text = ''
      data  /dev/disk/by-partlabel/data  /etc/data.keyfile
    '';
  };

  # TODO: Remove this if/when machine is reinstalled.
  # This is a workaround for the legacy -> gpt tables disko format.
  fileSystems = {
    "/".device = lib.mkForce "/dev/disk/by-partlabel/root";
    "/boot".device = lib.mkForce "/dev/disk/by-partlabel/ESP";
    "/.snapshots".device = lib.mkForce "/dev/disk/by-partlabel/root";
    "/.swap".device = lib.mkForce "/dev/disk/by-partlabel/root";
    "/home".device = lib.mkForce "/dev/disk/by-partlabel/root";
    "/nix".device = lib.mkForce "/dev/disk/by-partlabel/root";
    "/var".device = lib.mkForce "/dev/disk/by-partlabel/root";
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
          type = "gpt";
          partitions = {
            ESP = {
              start = "0%";
              end = "512MiB";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            root = {
              start = "512MiB";
              end = "100%";
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
          };
        };
      };

      # 4TB data drive. LUKS encrypted with single btrfs subvolume.
      sda = {
        device = "/dev/sda";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            data = {
              start = "0%";
              end = "100%";
              content = {
                type = "luks";
                name = "data";

                settings = {
                  # Make sure there is no trailing newline in keyfile if used for interactive unlock.
                  #  Use `echo -n "password" > /tmp/secret.key`
                  keyFile = "/tmp/data.keyfile";
                  allowDiscards = true;
                };

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
            };
          };
        };
      };
    };
  };
}

{ pkgs, lib, ... }:
{
  basePackages =
    with pkgs;
    [
      agenix
      bat
      binutils
      curl
      cyme
      dig
      dua
      duf
      eza
      fd
      file
      git
      jq
      killall
      ntfs3g
      openssh
      pciutils
      ripgrep
      rsync
      tree
      unzip
      vim
      wget
      yq-go
    ]
    ++ lib.optionals pkgs.stdenv.isLinux [
      nfs-utils
      tpm2-tss
      traceroute
      usbutils
    ];
}

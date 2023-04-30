{ lib, hostname, ... }: {
  imports = [ ]
    ++ lib.optional (builtins.pathExists (./. + "/${hostname}.nix")) ./${hostname}.nix;
}

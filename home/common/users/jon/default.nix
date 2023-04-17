{ lib, hostname, ... }: {
  # Import any per-host overrides for the 'jon' user
  imports = [ ] ++ lib.optional (builtins.pathExists (./. + "${hostname}")) ./${hostname}.nix;
}

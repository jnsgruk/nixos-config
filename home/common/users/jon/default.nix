{ lib, hostname, ... }:
let
  # If there is a ./${hostname}.nix then add it to a list of imports.
  # Allows for per-user, per-host customisation where required.
  extraHostConfig = (./. + "/${hostname}.nix");
  extraHostImport = if (builtins.pathExists extraHostConfig) then [ extraHostConfig ] else [ ];
in
{
  imports = [ ] ++ extraHostImport;
}

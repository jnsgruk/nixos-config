{
  desktop,
  lib,
  hostname,
  ...
}:
{
  imports = [
    ./base.nix
  ] ++ lib.optional (builtins.isString desktop) ./desktop.nix;
}

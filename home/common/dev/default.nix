{
  desktop,
  lib,
  ...
}:
{
  imports = [
    ./base.nix
  ] ++ lib.optional (builtins.isString desktop) ./desktop.nix;
}

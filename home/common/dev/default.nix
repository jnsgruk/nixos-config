{ desktop, lib, ... }: {
  imports = [
    ./charm-tools.nix
    ./base.nix
  ] ++ lib.optional (builtins.isString desktop) ./desktop.nix;
}

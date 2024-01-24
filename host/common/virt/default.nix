{ desktop, lib, ... }: {
  imports = [
    ./docker.nix
    ./lxd.nix
    ./multipass.nix
  ] # Include quickemu if a desktop is defined
  ++ lib.optional (builtins.isString desktop) ./quickemu.nix;
}

{ desktop, lib, ... }: {
  imports = [
    ./embr.nix
    ./docker.nix
    ./lxd
    ./multipass.nix
  ] # Include quickemu if a desktop is defined
  ++ lib.optional (builtins.isString desktop) ./quickemu.nix;
}

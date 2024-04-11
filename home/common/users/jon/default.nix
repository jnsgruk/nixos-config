{
  inputs,
  lib,
  hostname,
  ...
}:
{
  imports = [
    inputs.vscode-server.nixosModules.home
  ] ++ lib.optional (builtins.pathExists (./. + "/${hostname}.nix")) ./${hostname}.nix;

  services = {
    # Following install, you may need to run:
    # systemctl --user enable auto-fix-vscode-server.service
    # systemctl --user start auto-fix-vscode-server.service
    vscode-server.enable = true;
  };
}

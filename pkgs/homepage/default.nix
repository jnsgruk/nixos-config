{ pkgs, lib, ... }:
let
  homepageServer = pkgs.callPackage ./server.nix { };

  launcher = pkgs.writeShellScriptBin "homepage" ''
    export HOMEPAGE_CONFIG_DIR="''${HOMEPAGE_CONFIG_DIR:-$XDG_CONFIG_HOME/homepage}"
    export PORT="''${PORT:-3000}"
    exec ${lib.getExe pkgs.nodejs} ${homepageServer}/server.js
  '';
in
pkgs.symlinkJoin {
  name = "homepage-${homepageServer.version}";
  paths = [
    homepageServer
    launcher
  ];
}

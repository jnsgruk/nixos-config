{ pkgs, lib, ... }:
let
  sway-run = pkgs.writeShellScriptBin "sway-run" ''
    export XDG_SESSION_TYPE="wayland"
    export XDG_SESSION_DESKTOP="sway"
    export XDG_CURRENT_DESKTOP="sway"

    systemd-run --user --scope --collect --quiet --unit="sway" \
        systemd-cat --identifier="sway" ${pkgs.sway}/bin/sway $@

    ${pkgs.sway}/bin/swaymsg exit
  '';
in
{
  imports = [ (import ./tiling-common.nix { inherit lib pkgs; runner = (lib.getExe sway-run); }) ];

  xdg = {
    portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
    };
  };
}

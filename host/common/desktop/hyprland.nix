{ pkgs, lib, ... }:
let
  hypr-run = pkgs.writeShellScriptBin "hypr-run" ''
    export XDG_SESSION_TYPE="wayland"
    export XDG_SESSION_DESKTOP="Hyprland"
    export XDG_CURRENT_DESKTOP="Hyprland"

    systemd-run --user --scope --collect --quiet --unit="hyprland" \
        systemd-cat --identifier="hyprland" ${pkgs.hyprland}/bin/Hyprland $@

    ${pkgs.hyprland}/bin/hyperctl dispatch exit
  '';
in
{
  imports = [ (import ./tiling-common.nix { inherit lib pkgs; runner = (lib.getExe hypr-run); }) ];

  programs = {
    hyprland = {
      enable = true;
      package = pkgs.hyprland-hidpi;
      xwayland = {
        enable = true;
        hidpi = true;
      };
    };
  };
}

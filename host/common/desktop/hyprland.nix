{
  pkgs,
  lib,
  self,
  ...
}:
let
  theme = import "${self}/lib/theme" { inherit pkgs; };
  hypr-run = pkgs.writeShellScriptBin "hypr-run" ''
    export XDG_SESSION_TYPE="wayland"
    export XDG_SESSION_DESKTOP="Hyprland"
    export XDG_CURRENT_DESKTOP="Hyprland"
    export GTK_THEME=${theme.gtkTheme.name}

    systemd-run --user --scope --collect --quiet --unit="hyprland" \
        systemd-cat --identifier="hyprland" ${pkgs.hyprland}/bin/Hyprland $@

    ${pkgs.hyprland}/bin/hyprctl dispatch exit
  '';
in
{
  imports = [ ./tiling-common.nix ];

  programs.hyprland.enable = true;

  services.greetd.settings.default_session.command = ''
    ${lib.makeBinPath [ pkgs.greetd.tuigreet ]}/tuigreet -r --asterisks --time \
      --cmd ${lib.getExe hypr-run}
  '';
}

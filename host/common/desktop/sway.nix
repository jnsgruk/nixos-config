{
  pkgs,
  lib,
  self,
  ...
}:
let
  theme = import "${self}/lib/theme" { inherit pkgs; };
  sway-run = pkgs.writeShellScriptBin "sway-run" ''
    export XDG_SESSION_TYPE="wayland"
    export XDG_SESSION_DESKTOP="sway"
    export XDG_CURRENT_DESKTOP="sway"
    export GTK_THEME=${theme.gtkTheme.name}

    systemd-run --user --scope --collect --quiet --unit="sway" \
        systemd-cat --identifier="sway" ${pkgs.sway}/bin/sway $@

    ${pkgs.sway}/bin/swaymsg exit
  '';
in
{
  imports = [ ./tiling-common.nix ];

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  services.greetd.settings.default_session.command = ''
    ${lib.makeBinPath [ pkgs.greetd.tuigreet ]}/tuigreet -r --asterisks --time \
      --cmd ${lib.getExe sway-run}
  '';
}

{ hostname, inputs, lib, pkgs, theme, ... }:
let
  appearance = builtins.readFile ./config/appearance.conf;
  keybinds = builtins.readFile ./config/keybinds.conf;
  machineInputs = builtins.readFile ./config/inputs.conf;
  machineOutputs = (import ./config/displays.nix { }).${hostname}.outputs;
  windowRules = builtins.readFile ./config/window-rules.conf;
  workspaceAssignments = (import ./config/displays.nix { }).${hostname}.workspace-assignments;
in
{
  imports = [
    inputs.hyprland.homeManagerModules.default

    ../rofi
    ../waybar

    ../mako.nix
    ../swappy.nix
    ../swaylock.nix
    ../wl-common.nix

    ./packages.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland-hidpi;
    recommendedEnvironment = true;

    xwayland = {
      enable = true;
      hidpi = true;
    };

    extraConfig = ''
      ${appearance}
      ${keybinds}
      ${machineInputs}
      ${machineOutputs}
      ${windowRules}
      ${workspaceAssignments}
    '';
  };

  home.sessionVariables = {
    _JAVA_AWT_WM_NONREPARENTING = "1";
    CLUTTER_BACKEND = "wayland";
    GDK_BACKEND = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
  };

  systemd.user.services.swaybg = {
    Unit.Description = "swaybg";
    Install.WantedBy = [ "graphical-session.target" ];
    Service = {
      Type = "simple";
      ExecStart = "${lib.getExe pkgs.swaybg} -m fill -i ${theme.wallpaper}";
      Restart = "on-failure";
    };
  };
}

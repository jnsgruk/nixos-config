{ hostname, inputs, lib, pkgs, ... }:
let
  workspaceAssignments = (import ./config/displays.nix { }).${hostname}.workspace-assignments;
  machineOutputs = (import ./config/displays.nix { }).${hostname}.outputs;
  machineInputs = builtins.readFile ./config/inputs.conf;
  appearance = builtins.readFile ./config/appearance.conf;
  keybinds = builtins.readFile ./config/keybinds.conf;
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
      ${machineOutputs}
      ${machineInputs}
      ${workspaceAssignments}
      ${appearance}
      ${keybinds}
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
      ExecStart = "${lib.getExe pkgs.swaybg} -m fill -i ${../wallpapers/elk-colors.jpg}";
      Restart = "on-failure";
    };
  };
}

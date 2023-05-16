{ pkgs, lib, desktop, ... }: rec {
  # For some reason, waybar cannot find rofi in the path when executing this script.
  # This hack just hard-codes the path at the top of the file, with the packages needed
  rofi-power = pkgs.writeShellScriptBin "rofi-power-menu" ''
      export PATH=${lib.makeBinPath (with pkgs;[
      rofi-wayland
      systemd
      swaylock-effects
    ]
    ++ lib.optional (desktop == "sway") sway
    ++ lib.optional (desktop == "hyprland") hyprland)}
    
    ${(builtins.readFile ./powermenu.sh)}
  '';
}

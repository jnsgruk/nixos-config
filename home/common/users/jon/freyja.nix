{
  lib,
  pkgs,
  self,
  ...
}:
let
  # This isn't a NixOS machine, so the normal host-level packages aren't
  # automatically available.
  inherit ((import "${self}/host/common/base/packages.nix" { inherit pkgs; })) basePackages;
in
{
  targets.genericLinux.enable = true;

  home.packages =
    basePackages
    # Add additional packages which would usually be added at the NixOS
    # host level.
    ++ (with pkgs; [
      _1password-gui
      nh
      yubikey-manager

      (nerdfonts.override { fonts = [ "Meslo" ]; })
      inter
    ]);

  # Work around default Ubuntu config in /etc/X11/Xsession.d/90gpg-agent.
  programs.zsh.envExtra = ''
    SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent
  '';

  services = {
    ssh-agent.enable = true;
    syncthing = {
      enable = true;
      extraOptions = [
        "-gui-address=freyja.tailnet-d5da.ts.net:8384"
        "-home=/home/jon/data/.syncthing"
      ];
    };
  };
}

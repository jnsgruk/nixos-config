{ pkgs, config, lib, ... }:
let
  theme = (import ../../../home/common/desktop/gtk.nix { inherit pkgs config; }).gtk.theme.name;

  swayRun = pkgs.writeShellScript "sway-run" ''
    export XDG_SESSION_TYPE=wayland
    export XDG_SESSION_DESKTOP=sway
    export XDG_CURRENT_DESKTOP=sway
    systemd-run \
      --user \
      --scope \
      --collect \
      --quiet \
      --unit=sway \
      systemd-cat \
      --identifier=sway \
      ${pkgs.sway}/bin/sway \
      $@; ${pkgs.sway}/bin/swaymsg exit
  '';
in
{
  environment = {
    variables.NIXOS_OZONE_WL = "1";

    systemPackages = with pkgs; [
      polkit_gnome
      gnome.nautilus
    ];
  };

  services = {
    dbus = {
      enable = true;
      # Make the gnome keyring work properly
      packages = [ pkgs.gnome3.gnome-keyring pkgs.gcr ];
    };

    gnome = {
      at-spi2-core.enable = true;
      gnome-keyring.enable = true;
      sushi.enable = true;
    };

    greetd = {
      enable = true;
      restart = false;
      settings = {
        default_session = {
          command = "${lib.makeBinPath [pkgs.greetd.tuigreet]}/tuigreet -r --asterisks --time --cmd ${swayRun}";
        };
      };
    };

    gvfs.enable = true;
  };

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      unitConfig = {
        Description = "polkit-gnome-authentication-agent-1";
        Wants = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ];
      };
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  security = {
    pam = {
      services = {
        # allow wayland lockers to unlock the screen
        swaylock.text = "auth include login";
        # unlock gnome keyring automatically with greetd
        greetd.enableGnomeKeyring = true;
      };
    };
  };

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

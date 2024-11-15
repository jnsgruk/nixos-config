{
  hostname,
  inputs,
  lib,
  outputs,
  pkgs,
  platform,

  ...
}:

{
  imports = [
    ./${hostname}
    ./common
    ./common/scripts
  ];

  networking = {
    hostName = hostname;
    computerName = hostname;
  };

  environment = {
    shells = [ pkgs.zsh ];
    variables = {
      SSH_AUTH_SOCK = "~/.ssh/agent";
    };
  };

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };
  };

  nixpkgs = {
    hostPlatform = lib.mkDefault "${platform}";

    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
      inputs.agenix.overlays.default
    ];

    config = {
      allowUnfree = true;
      joypixels.acceptLicense = true;
    };
  };

  nix = {
    optimise.automatic = true;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      warn-dirty = false;
      trusted-users = [
        "jon"
      ];
    };
  };

  # Enable TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;

  services = {
    activate-system.enable = true;
    nix-daemon.enable = true;
    tailscale.enable = true;
  };

  system = {
    # Nix Darwin state version.
    stateVersion = 5;
    # activationScripts run every time you boot the system or execute `darwin-rebuild`
    activationScripts = {
      diff = {
        supportsDryActivation = true;
        text = ''
          ${pkgs.nvd}/bin/nvd --nix-bin-dir=${pkgs.nix}/bin diff /run/current-system "$systemConfig"
        '';
      };

      postUserActivation.text = ''
        # reload the settings and apply them without the need to logout/login
        /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u

        # disable the built-in ssh agent
        launchctl disable user/$UID/com.openssh.ssh-agent
      '';
    };
  };
}

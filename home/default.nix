{ config, desktop, lib, outputs, stateVersion, username, ... }:
{
  # Only import desktop configuration if the host is desktop enabled
  # Only import user specific configuration if they have bespoke settings
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    ./common/shell
  ]
  ++ lib.optional (builtins.isString desktop) ./common/desktop
  ++ lib.optional (builtins.isPath (./. + "/common/users/${username}")) ./common/users/${username};

  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = stateVersion;
  };

  nixpkgs = {
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default
    ];
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
      permittedInsecurePackages = [
        "electron-18.1.0"
      ];
    };
  };
}

{
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs {pkgs = final;};

  modifications = final: prev: {
    # Get latest commit from swaylock-effects to fix Sway 1.8 issue
    swaylock-effects = prev.swaylock-effects.overrideAttrs (old: {
      version = "1.6.10+cd07dd10";
      src = prev.fetchFromGitHub {
        owner = "jirutka";
        repo = "swaylock-effects";
        rev = "cd07dd1082a2fc1093f1e6f2541811e446f4d114";
        hash = "sha256-aK/PvFjZoF8R0llXO+P650vHYLSoGS6dYSk5Pw8DBNY=";
      };
    });

    # Augment the tmuxPlugins package with an additional 'catppuccin' theme plugin
    tmuxPlugins =
      prev.tmuxPlugins
      // {
        catppuccin = prev.tmuxPlugins.mkTmuxPlugin {
          pluginName = "catppuccin";
          version = "e2561de";
          src = prev.fetchFromGitHub {
            owner = "catppuccin";
            repo = "tmux";
            rev = "e2561decc2a4e77a0f8b7c05caf8d4f2af9714b3";
            sha256 = "sha256-6UmFGkUDoIe8k+FrzdzsKrDHHMNfkjAk0yyc+HV199M=";
          };
          postInstall = ''
            sed -i -e 's|''${PLUGIN_DIR}/catppuccin-selected-theme.tmuxtheme|''${TMUX_TMPDIR}/catppuccin-selected-theme.tmuxtheme|g' $target/catppuccin.tmux
          '';
        };
      };
  };
}

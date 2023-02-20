{
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs { pkgs = final; };

  modifications = _final: prev: {
    # Get latest commit from swaylock-effects to fix Sway 1.8 issue
    # swaylock-effects = prev.swaylock-effects.overrideAttrs (_old: {
    #   version = "1.6.10+cd07dd10";
    #   src = prev.fetchFromGitHub {
    #     owner = "jirutka";
    #     repo = "swaylock-effects";
    #     rev = "cd07dd1082a2fc1093f1e6f2541811e446f4d114";
    #     hash = "sha256-aK/PvFjZoF8R0llXO+P650vHYLSoGS6dYSk5Pw8DBNY=";
    #   };
    # });

    vimPlugins = prev.vimPlugins // {
      catppuccin-nvim = prev.vimUtils.buildVimPluginFrom2Nix {
        pname = "catppuccin-nvim";
        version = "2023-02-12";

        src = prev.fetchFromGitHub {
          owner = "catppuccin";
          repo = "nvim";
          rev = "a5f3ed5d3b1d9ea21183718a8a89a6653bd6ea48";
          sha256 = "1vx7p3f8339v1w9ww9l1lg3s6wf699q2bp762aqkmwmh88ykhi8i";

        };
      };
    };

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

{
  # Adds my custom packages
  # additions = final: _prev: import ../pkgs { pkgs = final; };

  # Modifies existing packages
  modifications = final: prev: {
    # Augment the tmuxPlugins package with an additional 'catppuccin' theme plugin
    tmuxPlugins = prev.tmuxPlugins // {
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

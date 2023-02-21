{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraConfig = ''
      set autochdir
      set autoindent
      set background=dark
      set bs=indent,eol,start
      set cindent
      set expandtab
      set hlsearch
      set ignorecase
      set nobackup
      set number
      set shiftwidth=2
      set showmatch
      set smartindent
      set smarttab
      set softtabstop=2
      set tabstop=2
      set termguicolors
    '';

    plugins = with pkgs.vimPlugins; [
      vim-nix
      {
        plugin = lightline-vim;
        type = "viml";
        config = ''
          let g:lightline = {'colorscheme': 'catppuccin'}
        '';
      }
      {
        # plugin = catppuccin-nvim;
        plugin =
          (catppuccin-nvim.overrideAttrs (_: {
            patches = [
              (pkgs.fetchpatch { url = "https://github.com/catppuccin/nvim/pull/414/commits/bfe533cb9c42c776a802f8f7802182b5fbf0876a.patch"; sha256 = "sha256-rxhpAJqXBp2rbAHqzyXGadr7zgYChafgaPDa4EpBaPA="; })
              (pkgs.fetchpatch { url = "https://github.com/catppuccin/nvim/pull/414/commits/589571e86cc93b67023efe59ad74fc7fe9dc5d37.patch"; sha256 = "sha256-I+whdbdWj7OgNU16UNTl5CHPy6HqBVqiNpGgVgluBOg="; })
            ];
          }));
        type = "lua";
        config = ''
          require('catppuccin').setup {
              flavour = 'macchiato',
              term_colors = true,
          }
          vim.api.nvim_command 'colorscheme catppuccin'
        '';
      }
    ];
  };
}

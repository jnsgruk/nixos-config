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
        plugin = catppuccin-nvim;
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

{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraLuaConfig = ''
      vim.opt.autochdir = true
      vim.opt.backup = false

      vim.opt.autoindent = true
      vim.opt.cindent = true
      vim.opt.smartindent = true

      vim.opt.expandtab = true
      vim.opt.shiftwidth = 2
      vim.opt.smarttab = true
      vim.opt.softtabstop = 2
      vim.opt.tabstop = 2

      vim.opt.backspace = "indent,eol,start"

      vim.opt.hlsearch = true
      vim.opt.ignorecase = true
      vim.opt.showmatch = true

      vim.opt.number = true
      vim.opt.background = dark
      vim.opt.termguicolors = true
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

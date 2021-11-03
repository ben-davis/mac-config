call plug#begin('~/.config/nvim/plugged')

" Easier LSP configuration
Plug 'neovim/nvim-lspconfig'
" Handles automatically installing language servers locally
Plug 'williamboman/nvim-lsp-installer'
" LSP-supported autocomplete
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
" LSP-icons in autocomplet
Plug 'onsails/lspkind-nvim'

" Snippets
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" Highlight symbols under cursor
" Dsiabled as it feels weird on insert mode
" Plug 'RRethy/vim-illuminate'
" Status line
Plug 'nvim-lua/lsp-status.nvim'

" Outline
" NOTE: Don't use
Plug 'simrat39/symbols-outline.nvim'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

" Telescope for lsp popup lists
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-github.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" Reload nvim without restarting
Plug 'famiu/nvim-reload'

" Search and replace
Plug 'windwp/nvim-spectre'

" Dev icons
Plug 'kyazdani42/nvim-web-devicons' " for file icons
" LSP-enabled explorer
Plug 'kyazdani42/nvim-tree.lua'

" Theme
" Looks abandoned
" Plug 'ayu-theme/ayu-vim'
Plug 'Luxed/ayu-vim'
Plug 'folke/tokyonight.nvim'

" Git support
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" Git signs
Plug 'lewis6991/gitsigns.nvim'

" Testing
Plug 'janko/vim-test'

" Lots of language syntax support
Plug 'sheerun/vim-polyglot'

" For easy commenting out 
Plug 'tpope/vim-commentary'

" Useful commands for common tasks
Plug 'tpope/vim-eunuch'

" Multiple cursors
Plug 'mg979/vim-visual-multi'

" DB access
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'

" Make it easy to use lazygit inside of vim
Plug 'kdheepak/lazygit.nvim'

" Doesn't work until neovim remote works
" let g:lazygit_use_neovim_remote = 1
let g:lazygit_floating_window_scaling_factor = 1

" Neovim easymotion-like thing
Plug 'ggandor/lightspeed.nvim'

" Allow buffer deletion without closing windows that had that buffer
Plug 'moll/vim-bbye'

" Dasht
Plug 'sunaku/vim-dasht'
Plug 'rhysd/devdocs.vim'

" Script writing
Plug 'kblin/vim-fountain'

" Autosave
Plug '907th/vim-auto-save'

" Status line
Plug 'nvim-lualine/lualine.nvim'

" Notificiations
Plug 'rcarriga/nvim-notify'

" DAP
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'

" Select window based on letter
Plug 'https://gitlab.com/yorickpeterse/nvim-window.git'

call plug#end()


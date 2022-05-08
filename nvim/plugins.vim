call plug#begin('~/.config/nvim/plugged')

" Easier LSP configuration
Plug 'neovim/nvim-lspconfig'
" Handles automatically installing language servers locally
Plug 'williamboman/nvim-lsp-installer'
" LSP-supported autocomplete
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'

Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}

" LSP Signature help
Plug 'ray-x/lsp_signature.nvim'
" LSP-icons in autocomplete
Plug 'onsails/lspkind-nvim'
" Adds support for schemastore to yaml/json LSP
Plug 'b0o/SchemaStore.nvim'

" Spell check
" Disabled as building lua-nuspell didn't work
" Plug 'f3fora/lua-nuspell'
" Plug 'f3fora/cmp-nuspell'

" Snippets
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" Highlight symbols under cursor
" Dsiabled as it feels weird on insert mode
" Plug 'RRethy/vim-illuminate'
" Status line
Plug 'nvim-lua/lsp-status.nvim'
" Provides context for the symbol under the cursor
Plug 'SmiteshP/nvim-gps'

" Outline
" NOTE: Don't use
Plug 'simrat39/symbols-outline.nvim'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

" Fixes Python indentation
Plug 'Vimjas/vim-python-pep8-indent'

" Telescope for lsp popup lists
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-github.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-project.nvim'
Plug 'TC72/telescope-tele-tabby.nvim'
Plug 'nvim-telescope/telescope-dap.nvim'

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
Plug 'pwntester/octo.nvim'
" Plug '~/dev/git/octo.nvim'
Plug 'sindrets/diffview.nvim'

" Git signs
Plug 'lewis6991/gitsigns.nvim'

" Testing
Plug 'janko/vim-test'
" Used to allow the same terminal to be used during test sessions
Plug 'kassio/neoterm'
" Used to run tests in a floating term
Plug 'voldikss/vim-floaterm'

" Lots of language syntax support
" NOTE: Disabled as we're using treesitter
" Plug 'sheerun/vim-polyglot'

" For easy commenting out 
Plug 'tpope/vim-commentary'

" Useful commands for common tasks
Plug 'tpope/vim-eunuch'
" Easily surround objects
Plug 'tpope/vim-surround'
" Repeat non-native commands
Plug 'tpope/vim-repeat'

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
Plug 'mrjones2014/dash.nvim', { 'do': 'make install' }

" Script writing
Plug 'kblin/vim-fountain'

" Autosave
Plug '907th/vim-auto-save'


" " Copy to clipboard
vnoremap  <leader>y OSCYank<CR>
" Status line
Plug 'nvim-lualine/lualine.nvim'

" Tab line
Plug 'alvarosevilla95/luatab.nvim'

" Notificiations
Plug 'rcarriga/nvim-notify'

" DAP
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'

" Select window based on letter
Plug 'https://gitlab.com/yorickpeterse/nvim-window.git'

" Autopairs
Plug 'windwp/nvim-autopairs'

" Zenmode, mostly for markdown editing
Plug 'folke/zen-mode.nvim'
Plug 'ellisonleao/glow.nvim'

" Email, because why not
Plug 'soywod/himalaya', {'rtp': 'vim'}

" Notes via zettl
Plug 'oberblastmeister/neuron.nvim'

Plug 'ojroques/vim-oscyank'
call plug#end()


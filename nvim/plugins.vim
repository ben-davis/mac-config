call plug#begin('~/.config/nvim/plugged')

" Easier LSP configuration
Plug 'neovim/nvim-lspconfig'
" Handles automatically installing language servers locally
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

" Autocomplete
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'
Plug 'ray-x/cmp-treesitter'
Plug 'hrsh7th/cmp-vsnip'
Plug 'windwp/nvim-autopairs'

" Snippets
Plug 'hrsh7th/vim-vsnip'

" LSP Signature help
Plug 'ray-x/lsp_signature.nvim'
" LSP-icons in autocomplete
Plug 'onsails/lspkind-nvim'
" LSP diagnostics as floating lines
Plug 'https://git.sr.ht/~whynothugo/lsp_lines.nvim'

" Formatting
Plug 'jose-elias-alvarez/null-ls.nvim'

" Adds support for schemastore to yaml/json LSP
Plug 'b0o/SchemaStore.nvim'

" Status line
Plug 'nvim-lua/lsp-status.nvim'

" Provides context for the symbol under the cursor
Plug 'SmiteshP/nvim-gps'

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
Plug 'TC72/telescope-tele-tabby.nvim'
Plug 'nvim-telescope/telescope-dap.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'ahmedkhalf/project.nvim'

" Search and replace
Plug 'windwp/nvim-spectre'

" Dev icons
Plug 'kyazdani42/nvim-web-devicons' " for file icons

" Theme
Plug 'folke/tokyonight.nvim'

" Git support
Plug 'tpope/vim-fugitive'
" Adds GBrowse command to fugitive
Plug 'tpope/vim-rhubarb'
" For GH coderevuew
Plug 'pwntester/octo.nvim'

" Show diffs
Plug 'sindrets/diffview.nvim'
" For blames
Plug 'rhysd/git-messenger.vim'

" Git signs
Plug 'lewis6991/gitsigns.nvim'

" Testing
Plug 'janko/vim-test'
" Used to allow the same terminal to be used during test sessions
Plug 'kassio/neoterm'
" Used to run tests in a floating term
Plug 'voldikss/vim-floaterm'

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

" Dasht
Plug 'mrjones2014/dash.nvim', { 'do': 'make install' }

" Script writing
 Plug 'kblin/vim-fountain'

" For prose writingA
Plug 'preservim/vim-pencil'

" Copy to clipboard
vnoremap  <leader>y OSCYank<CR>

" Status line
Plug 'nvim-lualine/lualine.nvim'

 " UI
Plug 'MunifTanjim/nui.nvim'
Plug 'rcarriga/nvim-notify'

" DAP
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'theHamsta/nvim-dap-virtual-text'

" Zenmode, mostly for markdown editing
Plug 'folke/zen-mode.nvim'

" Markdown preview
Plug 'ellisonleao/glow.nvim'

" Notes via zettl
Plug 'oberblastmeister/neuron.nvim'

Plug 'ojroques/vim-oscyank'

Plug 'folke/which-key.nvim'

" To preview gotos in a floating window
Plug 'rmagatti/goto-preview'

" Send requests
Plug '~/dev/git/rest.nvim'

" Note taking

Plug 'phaazon/mind.nvim'

call plug#end()



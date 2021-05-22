call plug#begin('~/.config/nvim/plugged')

" Easier LSP configuration
Plug 'neovim/nvim-lspconfig'
" Handles automatically installing language servers locally
Plug 'kabouzeid/nvim-lspinstall'
" LSP-supported autocomplete
Plug 'hrsh7th/nvim-compe'

" Telescope for lsp popup lists
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-github.nvim'

" Dev icons
Plug 'kyazdani42/nvim-web-devicons' " for file icons
" LSP-enabled explorer
Plug 'kyazdani42/nvim-tree.lua'

" Theme
" Looks abandoned
" Plug 'ayu-theme/ayu-vim'
Plug 'Luxed/ayu-vim'

" Git support
Plug 'tpope/vim-fugitive'
Plug 'rbong/vim-flog'
Plug 'rhysd/git-messenger.vim'
Plug 'tpope/vim-rhubarb'
Plug 'lambdalisue/gina.vim'

" Testing
Plug 'janko/vim-test'

" Debugging
Plug 'puremourning/vimspector'
" Default mappings
let g:vimspector_enable_mappings = 'HUMAN'

" Lots of language syntax support
Plug 'sheerun/vim-polyglot'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'michaeljsmith/vim-indent-object'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-eunuch'

" DB access
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'

" For seamless vim and tmux movement
Plug 'christoomey/vim-tmux-navigator'

Plug 'rhysd/devdocs.vim'

Plug 'junegunn/fzf', {'dir': '~/.fzf','do': './install --all'}
Plug 'junegunn/fzf.vim'

" Non-node coc plugins
" Plug 'antoinemadec/coc-fzf'
" Alternative coc integration for fzf
" Plug 'yuki-ycino/fzf-preview.vim', { 'branch': 'release', 'do': ':UpdateRemotePlugins' }

" Reusable terminals
Plug 'kassio/neoterm'

" Base64
Plug 'christianrondeau/vim-base64'

" Make it easy to use lazygit inside of vim
Plug 'kdheepak/lazygit.nvim', { 'branch': 'nvim-v0.4.3' }
" Doesn't work until neovim remote works
" let g:lazygit_use_neovim_remote = 1
let g:lazygit_floating_window_scaling_factor = 1

" Yanking
Plug 'LeafCage/yankround.vim'

" Easymotion with ;
Plug 'easymotion/vim-easymotion'

" Allow buffer deletion without closing windows that had that buffer
Plug 'moll/vim-bbye'

" Shortcuts for todo list management inside markdown file
Plug 'aserebryakov/vim-todo-lists'

" Dasht
Plug 'sunaku/vim-dasht'

" Script writing
Plug 'kblin/vim-fountain'

" Autosave
Plug '907th/vim-auto-save'

" Distraction free coding/writing
Plug 'chrisbra/DistractFree'
let g:distractfree_width = '60%'
let g:distractfree_height= '100%'

" Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
Plug 'hoob3rt/lualine.nvim'

call plug#end()


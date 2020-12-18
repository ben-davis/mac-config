call plug#begin('~/.config/nvim/plugged')

" For LSP support
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Status line
Plug 'liuchengxu/eleline.vim'
set laststatus=2

" Theme
Plug 'ayu-theme/ayu-vim'

" Git support
Plug 'tpope/vim-fugitive'
Plug 'rbong/vim-flog'
Plug 'rhysd/git-messenger.vim'
Plug 'tpope/vim-rhubarb'
Plug 'lambdalisue/gina.vim'

" Testing
Plug 'janko/vim-test'


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
Plug 'antoinemadec/coc-fzf'
" Alternative coc integration for fzf
Plug 'yuki-ycino/fzf-preview.vim', { 'branch': 'release', 'do': ':UpdateRemotePlugins' }

" For LSP sidebar
Plug 'liuchengxu/vista.vim'

" Nice floating terminals
Plug 'voldikss/vim-floaterm'

" Reusable terminals
Plug 'kassio/neoterm'

" Base64
Plug 'christianrondeau/vim-base64'

" Make it easy to use lazygit inside of vim
Plug 'kdheepak/lazygit.nvim', { 'branch': 'nvim-v0.4.3' }

" Yanking
Plug 'LeafCage/yankround.vim'

" Easymotion with ;
Plug 'easymotion/vim-easymotion'

call plug#end()

" Source coc-nvim config
source ~/.config/nvim/plugin-config/coc-init.vim

set termguicolors
let ayucolor="mirage" 
colorscheme ayu

function! ToggleDarkModeFun()
    if g:ayucolor == 'mirage'
        let g:ayucolor="light" 
        colorscheme ayu
    else
        let g:ayucolor="mirage" 
        colorscheme ayu
    endif
endfunction

command! ToggleDarkMode :call ToggleDarkModeFun()

set mouse=a

" Spaces over tabs
set expandtab

augroup filetypes
        autocmd!
        autocmd Filetype python setlocal ts=4 sw=4
        autocmd Filetype javascript setlocal ts=2 sw=2
        autocmd Filetype typescript setlocal ts=2 sw=2
        autocmd Filetype typescriptreact setlocal ts=2 sw=2
        autocmd Filetype css setlocal ts=2 sw=2
        autocmd Filetype scss setlocal ts=2 sw=2
        autocmd Filetype html setlocal ts=2 sw=2
        autocmd Filetype htmldjango setlocal ts=2 sw=2
        autocmd Filetype liquid setlocal ts=2 sw=2
        autocmd Filetype json setlocal ts=2 sw=2
        autocmd Filetype xml setlocal ts=2 sw=2
        autocmd Filetype sh setlocal ts=2 sw=2
        autocmd Filetype vim setlocal ts=2 sw=2
        autocmd Filetype java setlocal ts=4 sw=4

        autocmd FileType markdown setlocal wrap tw=79

        autocmd VimResized * wincmd =
augroup END

let NERDTreeMinimalUI=1

set number

" Clear highlighting on escape in normal mode
nnoremap <silent> <esc> :noh<return><esc>

nnoremap <esc>^[ <esc>^[

" Change enter to new line in normal mode
" Shift-enter for new line above.
nnoremap <CR> o<esc>
nnoremap <S-CR> O<esc>
inoremap <S-CR> <esc>O

" Change visual paste to not yank the deleted characters
vnoremap p "_dP

" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
" nnoremap  <leader>yy  "+yy

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Terminal mode
" tnoremap <Esc> <C-\><C-n>

tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l

" No line numbers in terminal
augroup terminallinenumbers
  autocmd!
  au TermOpen * setlocal nonumber norelativenumber
augroup END

" Devdocs
nmap <leader>k <Plug>(devdocs-under-cursor)

" Navigating quickfix
" nnoremap <silent> <C-j> :cnext<CR>	
" nnoremap <silent> <C-k> :cprev<CR>	

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
let g:floaterm_width = 0.9
let g:floaterm_height = 0.6

" Hybrid numbers
set relativenumber
set nu rnu

" Toggled between relative and absolute when switching from normal to insert
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" Test configuration
let test#strategy = "neoterm"
let test#preserve_screen = 0
nnoremap <silent> <leader>tn :TestNearest<CR>
nnoremap <silent> <leader>tf :TestFile<CR>
nnoremap <silent> <leader>tl :TestLast<CR>
nnoremap <silent> <leader>ts :TestSuite<CR>

" let test#javascript#jest#options = {
"   \ 'nearest': '--watch',
"   \ 'file':    '--watch'
" \}
"
nnoremap <silent> <leader>s :FloatermToggle<CR>
tnoremap <silent> <leader>s :FloatermToggle<CR>
nnoremap <silent> <leader>l :LazyGit<CR>


" Auto scroll terminals
let g:neoterm_autoscroll = 1

" Easier escape from terminal
tnoremap <leader><Esc> <C-\><C-n>

" For performance
set lazyredraw

" Set python to system python3.9 so a virtualenv doesn't override it.
let g:python3_host_prog = "/usr/local/bin/python3"

" Use smart case when searching
set ignorecase
set smartcase

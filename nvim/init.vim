call plug#begin('~/.config/nvim/plugged')

" For LSP support
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Status line
Plug 'ben-davis/eleline.vim'
set laststatus=2
let g:eleline_powerline_fonts = 1

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
" Doesn't work until neovim remote works
" let g:lazygit_use_neovim_remote = 1

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

call plug#end()

" Source coc-nvim config
source ~/.config/nvim/plugin-config/coc-init.vim

set termguicolors
let ayucolor="dark" 
colorscheme ayu

function! ToggleDarkModeFun()
    if g:ayucolor == 'dark'
        let g:ayucolor="light" 
        colorscheme ayu
    else
        let g:ayucolor="dark" 
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
  autocmd TermOpen * setlocal nonumber norelativenumber
  au BufEnter,BufWinEnter,WinEnter term://* startinsert
  au BufLeave term://* stopinsert
augroup END

" Devdocs (disabled in favour of dasht)
" nmap <leader>k <Plug>(devdocs-under-cursor)

" Dasht
" search related docsets
nnoremap <Leader>k :Dasht<Space>

" search ALL the docsets
nnoremap <Leader><Leader>k :Dasht!<Space>

" search related docsets
nnoremap <silent> <Leader>K :call Dasht(dasht#cursor_search_terms())<Return>

" search ALL the docsets
nnoremap <silent> <Leader><Leader>K :call Dasht(dasht#cursor_search_terms(), '!')<Return>

" search related docsets
vnoremap <silent> <Leader>K y:<C-U>call Dasht(getreg(0))<Return>

" search ALL the docsets
vnoremap <silent> <Leader><Leader>K y:<C-U>call Dasht(getreg(0), '!')<Return>

let g:dasht_filetype_docsets = {}
" When in Python, also search Django
let g:dasht_filetype_docsets['python'] = ['Django']
let g:dasht_filetype_docsets['htmldjango'] = ['Django']
let g:dasht_filetype_docsets['javascript'] = ['React']
let g:dasht_filetype_docsets['typescript'] = ['React']
let g:dasht_filetype_docsets['typescriptreact'] = ['React']
let g:dasht_filetype_docsets['javascriptreact'] = ['React']
let g:dasht_results_window = 'vnew'

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
  autocmd BufEnter,FocusGained,InsertLeave * if &buftype != "terminal" | set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * if &buftype != "terminal" | set norelativenumber
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
nnoremap <silent> <leader>l :LazyGit<CR>

" Delete buffer
nnoremap <silent> <leader>q :Bdelete<CR>


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

" Custom mapper for todo lists (changes <space> map as we use that for
" coc-nvim)
let g:VimTodoListsCustomKeyMapper = 'VimTodoListsCustomMappings'

function! VimTodoListsCustomMappings()
  nnoremap <buffer><silent> o :VimTodoListsCreateNewItemBelow<CR>
  nnoremap <buffer><silent> O :VimTodoListsCreateNewItemAbove<CR>
  nnoremap <buffer><silent> j :VimTodoListsGoToNextItem<CR>
  nnoremap <buffer><silent> k :VimTodoListsGoToPreviousItem<CR>
  nnoremap <buffer><silent> s :VimTodoListsToggleItem<CR>
  vnoremap <buffer><silent> s :VimTodoListsToggleItem<CR>
  inoremap <buffer><silent> <CR> <ESC>:call VimTodoListsAppendDate()<CR>:silent call VimTodoListsCreateNewItemBelow()<CR>
  inoremap <buffer><silent> <kEnter> <ESC>:call VimTodoListsAppendDate()<CR>A<CR><ESC>:VimTodoListsCreateNewItem<CR>
  noremap <buffer><silent> <leader>e :silent call VimTodoListsSetNormalMode()<CR>
  nnoremap <buffer><silent> <Tab> :VimTodoListsIncreaseIndent<CR>
  nnoremap <buffer><silent> <S-Tab> :VimTodoListsDecreaseIndent<CR>
  vnoremap <buffer><silent> <Tab> :VimTodoListsIncreaseIndent<CR>
  vnoremap <buffer><silent> <S-Tab> :VimTodoListsDecreaseIndent<CR>
  inoremap <buffer><silent> <Tab> <ESC>:VimTodoListsIncreaseIndent<CR>A
  inoremap <buffer><silent> <S-Tab> <ESC>:VimTodoListsDecreaseIndent<CR>A
endfunction

" Configure neovim-remote
" NOTE: This is currently not working. Assuming because nvim 5 isn't setting
" server name correctly.
" if has('nvim') && executable('nvr')
"   let $GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
" endif

" Make V behave like C and D
nmap V v$
nmap vv ^v$

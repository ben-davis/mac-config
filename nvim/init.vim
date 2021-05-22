source ~/.config/nvim/plugins.vim

" LSP Config
:luafile ~/.config/nvim/lsp.lua

set termguicolors
set background=dark
let ayucolor="dark" 
colorscheme ayu

function! ToggleDarkModeFun()
    if g:ayucolor == 'dark'
        set background=light
        let g:ayucolor="light" 
        colorscheme ayu
    else
        set background=dark
        let g:ayucolor="dark" 
        colorscheme ayu
    endif
endfunction

command! ToggleDarkMode :call ToggleDarkModeFun()

" Support mouse
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

" Show line numbers always
set number

" Wrapped lines are indented
set breakindent

" Persist undo between sessions
set undofile

" Decrease updatetime (time to save to swap file)
set updatetime=250

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

" Hybrid numbers
set relativenumber
set nu rnu

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

" Y yank until the end of line
nnoremap <silent> Y y$

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

" Autosave fountain
let g:auto_save = 0
augroup autosave_fountain
  au!
  au FileType fountain let b:auto_save = 1
augroup END

" Without this, files will jump the the right when there are signs
set signcolumn=yes:1

" Causes unsaved buffers to be hidden rather than closed
set hidden

" Neovim live substitution
set inccommand="nosplit"

" Highlight on yank
augroup YankHighlight
  autocmd!
  autocmd TextYankPost * silent! lua vim.highlight.on_yank()
augroup end

" Support project-local .nvimrc
set exrc

" Open explorer
noremap <Leader>d :NvimTreeToggle<CR>

" nvim-tree
let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache', '.mypy_cache' ]
let g:nvim_tree_follow = 1
let g:nvim_tree_auto_close = 1
let g:nvim_tree_git_hl = 1
let g:nvim_tree_lsp_diagnostics = 1

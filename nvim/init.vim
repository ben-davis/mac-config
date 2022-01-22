source ~/.config/nvim/plugins.vim

:lua require('lsp')
:lua require('status-line')
:lua require('tab-line')
:lua require('dap-config')
:lua require('projects')

set termguicolors
set background=dark
" let ayucolor="dark" 
"
" colorscheme ayu
let g:tokyonight_style = "storm"
colorscheme tokyonight
let g:tokyonight_lualine_bold = 1
let g:tokyonight_hide_inactive_statusline = 1
let g:tokyonight_italic_functions = 1
let g:tokyonight_italic_keywords = 1

function! ToggleDarkModeFun()
    " if g:ayucolor == 'dark'
    if g:tokyonight_style == "day"
        " set background=light
        " let g:ayucolor="light" 
        " colorscheme ayu
        " :lua require'status-line'.setup("ayu_light")
        let g:tokyonight_style = "night"
        set background=dark
        :lua require'status-line'.setup("tokyonight")
        colorscheme tokyonight
    else
        " set background=dark
        " let g:ayucolor="dark" 
        " colorscheme ayu
        " :lua require'status-line'.setup("ayu_dark")
        let g:tokyonight_style = "day"
        set background=light
        :lua require'status-line'.setup("tokyonight")
        colorscheme tokyonight
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
        autocmd Filetype scheme setlocal ts=2 sw=2
        autocmd Filetype c setlocal ts=2 sw=2
        autocmd Filetype lua setlocal ts=2 sw=2

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


" Normal/insert mode movement
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Terminal mode movement
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l

" Use gx to open URLs.
nmap <silent> gx :!open <cWORD><cr>

" No line numbers in terminal
augroup terminallinenumbers
  autocmd!
  autocmd TermOpen * setlocal nonumber norelativenumber
  " NOTE: I'm not enjoying the auto-insert on enter, so disabling for now.
  " au BufEnter,BufWinEnter,WinEnter term://* startinsert
  " au BufLeave term://* stopinsert
augroup END

" Devdocs (disabled in favour of dasht)
" nmap <silent> <leader>k :DevDocsUnderCursor<CR>
" nmap <silent> <leader>K :DevDocsAllUnderCursor<CR>

" Dasht (disabled in favor of Devdocs as w3m is too complicated / no syntax)
" " search related docsets
" nnoremap <Leader>k :Dasht<Space>

" " search ALL the docsets
" nnoremap <Leader><Leader>k :Dasht!<Space>

" " search related docsets
" nnoremap <silent> <Leader>K :call Dasht(dasht#cursor_search_terms())<Return>

" " search ALL the docsets
" nnoremap <silent> <Leader><Leader>K :call Dasht(dasht#cursor_search_terms(), '!')<Return>

" " search related docsets
" vnoremap <silent> <Leader>K y:<C-U>call Dasht(getreg(0))<Return>

" " search ALL the docsets
" vnoremap <silent> <Leader><Leader>K y:<C-U>call Dasht(getreg(0), '!')<Return>
"
nmap <silent> <leader>k :DashWord<CR>
nmap <silent> <space>k :Dash<CR>

lua << EOF
require('telescope').setup({
  extensions = {
    dash = {
      file_type_keywords = {
        python = 'python3'
      }
    }
  }
})
EOF

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

:lua require('dap').set_log_level('TRACE')

lua << EOF
function _G.dapLaunchDocker(cmd)
    local dap = require"dap"
    adapter = {
        type = "executable",
        command = "docker-compose",
        args = {"run", "--rm", "--service-ports", "test", "python", "-m", "debugpy", "--listen", "0.0.0.0:5678", "--wait-for-client", "-m", "pytest", cmd:gsub("pytest server/", "")}
    }

    config = {
        request = 'attach',
        name = "Rupa",
        pathMappings = {
            {
              localRoot = "/Users/ben/dev/git/rupalabs/server",
              remoteRoot = "/app",
            }
        },
    }

		dap.launch(adapter, config)
end
EOF

let DockerStrategy = luaeval('dapLaunchDocker')

let g:test#custom_strategies = {'docker': DockerStrategy}
let g:test#strategy = 'docker'

" let test#javascript#jest#options = {
"   \ 'nearest': '--watch',
"   \ 'file':    '--watch'
" \}
"
nnoremap <silent> <leader>l :LazyGit<CR>
" let g:lazygit_floating_window_use_plenary = 1

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

" Configure neovim-remote
" NOTE: This is currently not working. Assuming because nvim 5 isn't setting
" server name correctly.
if has('nvim') && executable('nvr')
  let $GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
endif

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

" Explorer
let g:symbols_outline = {
    \ "highlight_hovered_item": v:false,
    \ "show_guides": v:true,
    \ "position": 'right',
    \ "auto_preview": v:false,
    \ "show_numbers": v:true,
    \ "show_relative_numbers": v:false,
    \ "show_symbol_details": v:true,
    \ "keymaps": {
        \ "close": "<Esc>",
        \ "goto_location": "<Cr>",
        \ "focus_location": "o",
        \ "hover_symbol": "<C-space>",
        \ "rename_symbol": "r",
        \ "code_actions": "a",
    \ },
    \ "lsp_blacklist": [],
\ }

" Open outline
noremap <silent> <Leader>s :SymbolsOutline<CR>

" nvim-tree
let g:nvim_tree_git_hl = 1
let g:nvim_tree_highlight_opened_files = 1

lua <<EOF
require'nvim-tree'.setup({
    auto_close = true,
    update_focused_file = {
        enable = true
    },
    hijack_cursor = true,
    view = {
        width = 40
    },
    filters = {
        custom = { '.git', 'node_modules', '.cache', '.mypy_cache', '.pytest_cache', '__pycache__', '.DS_STORE' }
    },
    update_cwd = true
})
EOF

noremap <silent> <Leader>e :NvimTreeToggle<CR>
noremap <silent> <Leader>E :NvimTreeFindFile<CR>

" Search and replace
nnoremap <leader>S :lua require('spectre').open()<CR>

" Treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  },
}
EOF

" Git signs
:lua require('gitsigns').setup()

" Neovide
" Only set the font if
if &guifont == ""
    " set guifont=MonoLisa:h14
    " set guifont=Fira\ Code:h14
    set guifont=FiraCode\ Nerd\ Font:h14
    " set guifont=Apercu\ Pro\ Mono:h14
endif
let g:neovide_cursor_animation_length=0
" let g:neovide_refresh_rate=140
" let neovide_remember_window_size = v:true
let g:neovide_floating_blur = 0
let g:neovide_window_floating_opacity = 0
" let g:neovide_remember_window_size = v:true
let g:neovide_transparency = 0

" Set the fancy notification tool as the default one in vim
:lua vim.notify = require("notify")

" Easier window movement
lua << EOF
require('nvim-window').setup({
  -- The characters available for hinting windows.
  chars = {
    '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
    'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i',
    'j', 'k', 'l', 'm', 'n', 'o',
  },
})
EOF

map <silent> <leader>w :lua require('nvim-window').pick()<CR>

" Setup autopairs
lua << EOF
require('nvim-autopairs').setup({
    enable_check_bracket_line = false
})
EOF


" vsnip NOTE: for some reason when this is enabled I can't type repeated "
" imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
" smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
" imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
" smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" " Github
lua << EOF
require"octo".setup()
EOF

lua << EOF
require("zen-mode").setup()
EOF

" Allows window zooming by creating it in a new tab split
" nnoremap <silent> <leader>z :tab split<CR>
nnoremap <silent> <leader>z :ZenMode<CR>

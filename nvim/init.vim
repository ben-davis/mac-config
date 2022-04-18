source ~/.config/nvim/plugins.vim

:lua require('lsp')
:lua require('status-line')
:lua require('tab-line')
:lua require('dap-config')
:lua require('projects')

" set termguicolors
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
let g:tokyonight_dark_sidebar = "false"
let g:tokyonight_transparent_sidebar = 1

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

" Splits should open to the right
set splitright

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
        autocmd Filetype markdown setlocal ts=2 sw=2 wrap linebreak

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
vnoremap  <leader>y :OSCYank<CR>
" vnoremap  <leader>y  "+y
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
ensure_installed = "all",
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
    set guifont=JetBrainsMono\ Nerd\ Font:h14
    " set guifont=Apercu\ Pro\ Mono:h14
endif

let g:neovide_cursor_animation_length=0
let g:neovide_window_floating_opacity = 0

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
require"octo".setup({
  mappings = {
    pull_request = {
      reload = "gr",
      open_in_browser = "gb",
      checkout_pr = "<space>zaazazazaz",
      merge_pr = "<space>zazazaza",
      list_commits = "<space>zaajasd",
      list_changed_files = "<space>zaasfasd",
    }
  }
})
EOF

lua << EOF
require("zen-mode").setup()
EOF

" Allows window zooming by creating it in a new tab split
" nnoremap <silent> <leader>z :tab split<CR>
nnoremap <silent> <leader>z :ZenMode<CR>

nnoremap <silent> <space>g :Octo actions<CR>

" Set as many sub/super script digraphs as we can
execute "digraphs as " . 0x2090
execute "digraphs es " . 0x2091
execute "digraphs hs " . 0x2095
execute "digraphs is " . 0x1D62
execute "digraphs js " . 0x2C7C
execute "digraphs ks " . 0x2096
execute "digraphs ls " . 0x2097
execute "digraphs ms " . 0x2098
execute "digraphs ns " . 0x2099
execute "digraphs os " . 0x2092
execute "digraphs ps " . 0x209A
execute "digraphs rs " . 0x1D63
execute "digraphs ss " . 0x209B
execute "digraphs ts " . 0x209C
execute "digraphs us " . 0x1D64
execute "digraphs vs " . 0x1D65
execute "digraphs xs " . 0x2093

execute "digraphs aS " . 0x1d43
execute "digraphs bS " . 0x1d47
execute "digraphs cS " . 0x1d9c
execute "digraphs dS " . 0x1d48
execute "digraphs eS " . 0x1d49
execute "digraphs fS " . 0x1da0
execute "digraphs gS " . 0x1d4d
execute "digraphs hS " . 0x02b0
execute "digraphs iS " . 0x2071
execute "digraphs jS " . 0x02b2
execute "digraphs kS " . 0x1d4f
execute "digraphs lS " . 0x02e1
execute "digraphs mS " . 0x1d50
execute "digraphs nS " . 0x207f
execute "digraphs oS " . 0x1d52
execute "digraphs pS " . 0x1d56
execute "digraphs rS " . 0x02b3
execute "digraphs sS " . 0x02e2
execute "digraphs tS " . 0x1d57
execute "digraphs uS " . 0x1d58
execute "digraphs vS " . 0x1d5b
execute "digraphs wS " . 0x02b7
execute "digraphs xS " . 0x02e3
execute "digraphs yS " . 0x02b8
execute "digraphs zS " . 0x1dbb

execute "digraphs AS " . 0x1D2C
execute "digraphs BS " . 0x1D2E
execute "digraphs DS " . 0x1D30
execute "digraphs ES " . 0x1D31
execute "digraphs GS " . 0x1D33
execute "digraphs HS " . 0x1D34
execute "digraphs IS " . 0x1D35
execute "digraphs JS " . 0x1D36
execute "digraphs KS " . 0x1D37
execute "digraphs LS " . 0x1D38
execute "digraphs MS " . 0x1D39
execute "digraphs NS " . 0x1D3A
execute "digraphs OS " . 0x1D3C
execute "digraphs PS " . 0x1D3E
execute "digraphs RS " . 0x1D3F
execute "digraphs TS " . 0x1D40
execute "digraphs US " . 0x1D41
execute "digraphs VS " . 0x2C7D
execute "digraphs WS " . 0x1D42

" Email
let g:himalaya_mailbox_picker = 'telescope'
let g:himalaya_telescope_preview_enabled = 1

nmap <silent> <leader>m :Himalaya<CR>


function! Startup()
  " Create default projects
  :TabooRename rupalabs
  :tcd ~/dev/git/rupalabs

  :TabooOpen fastapi-rest-framework
  :tcd ~/dev/git/fastapi-rest-framework

  :TabooOpen notes
  :tcd ~/dev/git/notes

  :TabooOpen mac-config
  :tcd ~/dev/git/mac-config

  :TabooOpen email

  :tabfirst
endfunction


" NOTE: Disabling as I'm testing whether I want to have these open
" augroup startup
"   autocmd!
"   autocmd VimEnter * :call Startup()
" augroup END

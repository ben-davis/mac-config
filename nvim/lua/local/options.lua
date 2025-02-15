-- Support mouse
vim.o.mouse = "a"

-- System clipboard support
vim.g["oscyank_term"] = "default"

-- Spaces over tabs
vim.o.expandtab = true

-- Splits should open to the right
vim.o.splitright = true

-- Show line numbers always
vim.o.number = true

-- Hybrid numbers
vim.o.relativenumber = true
vim.o.nu = true
vim.o.rnu = true

-- Wrapped lines are indented
vim.o.breakindent = true

-- Persist undo between sessions
vim.o.undofile = true

-- Decrease updatetime (time to save to swap file)
vim.o.updatetime = 250

-- Without this, files will jump the the right when there are signs
vim.o.signcolumn = "yes:1"

-- Causes unsaved buffers to be hidden rather than closed
vim.o.hidden = true

-- Neovim live substitution
vim.o.inccommand = "nosplit"

-- Use smart case when searching
vim.o.ignorecase = true
vim.o.smartcase = true

-- For performance
vim.o.lazyredraw = true

-- Set cmdheight to 0
-- vim.o.cmdheight = 0

-- Auto scroll terminals
vim.g["neoterm_autoscroll"] = 1

-- Set python to system python3.9 so a virtualenv doesn't override it.
vim.g["python3_host_prog"] = "/usr/local/bin/python3"

-- Set the fancy notification tool as the default one in vim
vim.notify = require("notify")

-- Configure neovim-remote
-- NOTE: This is currently not working. Assuming because nvim 5 isn't setting
-- server name correctly.
vim.api.nvim_exec(
	[[
  if has('nvim') && executable('nvr')
    let $GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
  endif
  ]],
	true
)

-- Highlight on yank
vim.api.nvim_exec(
	[[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
  ]],
	true
)

-- Set filetype options
vim.api.nvim_exec(
	[[
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
        autocmd Filetype markdown setlocal ts=2 sw=2 wrap linebreak spell
        autocmd Filetype elixir setlocal ts=2 sw=2
        autocmd Filetype glsl setlocal ts=2 sw=2
        autocmd Filetype swift setlocal ts=2 sw=2
        autocmd Filetype rules setlocal ts=2 sw=2
        autocmd Filetype fish setlocal ts=4 sw=4
        autocmd Filetype gitcommit setlocal textwidth=0
    augroup END
  ]],
	true
)

vim.api.nvim_exec(
	[[
  augroup terminallinenumbers
    autocmd!
    autocmd TermOpen * setlocal nonumber norelativenumber
    " NOTE: I'm not enjoying the auto-insert on enter, so disabling for now.
    " au BufEnter,BufWinEnter,WinEnter term://* startinsert
    " au BufLeave term://* stopinsert
  augroup END
  ]],
	true
)

vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.api.nvim_exec("set nofoldenable", true)

-- For Obsidian.nvim to show checkboxes. The default of 3 doesn't work.
vim.opt.conceallevel = 1

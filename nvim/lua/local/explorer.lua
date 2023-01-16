vim.keymap.set("n", "<Leader>s", ":SymbolsOutline<CR>", { silent = true, noremap = true })

-- Using telescope as all explorers suck with tabs
vim.api.nvim_set_keymap("n", "<Leader>e", ":Telescope file_browser path=%:p:h<CR>", { noremap = true })

-- Using telescope as all explorers suck with tabs
vim.api.nvim_set_keymap("n", "<Leader>e", ":Telescope file_browser path=%:p:h<CR>", { noremap = true })

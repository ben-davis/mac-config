vim.keymap.set("n", "<Leader>s", ":SymbolsOutline<CR>", { silent = true, noremap = true })
-- Trying out neotree as nvim-tree has issues with tab cd
vim.keymap.set("n", "<Leader>e", ":Neotree toggle .<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<Leader>E", ":Neotree toggle reveal .<CR>", { silent = true, noremap = true })
-- vim.keymap.set("n", "<Leader>e", ":NvimTreeToggle<CR>", { silent = true, noremap = true })
-- vim.keymap.set("n", "<Leader>E", ":NvimTreeFindFile<CR>", { silent = true, noremap = true })

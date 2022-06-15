vim.g["nvim_tree_git_hl"] = 1
vim.g["nvim_tree_highlight_opened_files"] = 1

require("nvim-tree").setup({
	update_focused_file = {
		enable = true,
	},
	hijack_cursor = true,
	view = {
		width = 40,
	},
	filters = {
		custom = { ".git", "node_modules", ".cache", ".mypy_cache", ".pytest_cache", "__pycache__", ".DS_STORE" },
	},
})

vim.keymap.set("n", "<Leader>s", ":SymbolsOutline<CR>", { silent = true, noremap = true })
-- Trying out neotree as nvim-tree has issues with tab cd
vim.keymap.set("n", "<Leader>e", ":Neotree toggle .<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<Leader>E", ":Neotree toggle reveal .<CR>", { silent = true, noremap = true })
-- vim.keymap.set("n", "<Leader>e", ":NvimTreeToggle<CR>", { silent = true, noremap = true })
-- vim.keymap.set("n", "<Leader>E", ":NvimTreeFindFile<CR>", { silent = true, noremap = true })

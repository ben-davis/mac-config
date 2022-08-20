vim.keymap.set("n", "<Leader>s", ":SymbolsOutline<CR>", { silent = true, noremap = true })
-- Trying out neotree as nvim-tree has issues with tab cd
vim.keymap.set("n", "<Leader>e", ":Neotree toggle .<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<Leader>E", ":Neotree toggle reveal .<CR>", { silent = true, noremap = true })
-- vim.keymap.set("n", "<Leader>e", ":NvimTreeToggle<CR>", { silent = true, noremap = true })
-- vim.keymap.set("n", "<Leader>E", ":NvimTreeFindFile<CR>", { silent = true, noremap = true })

require("neo-tree").setup({
	filesystem = {
		commands = {
			-- Override delete to use trash instead of rm
			delete = function(state)
				local path = state.tree:get_node().path
				vim.fn.system({ "trash", vim.fn.fnameescape(path) })
                                require("neo-tree.sources.manager").refresh(state.name)
			end,
		},
	},
})

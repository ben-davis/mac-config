-- Using telescope as all explorers suck with tabs
-- Configured in `jelescope.lua`
vim.api.nvim_set_keymap("n", "<Leader>e", ":Telescope file_browser path=%:p:h<CR>", { noremap = true })

require("neo-tree").setup({
	-- Enabling git creates tons of UI lag
	enable_git_status = false,
	enable_diagnostics = false,
	buffers = {
		follow_current_file = {
			enabled = true,
		},
	},
})

vim.api.nvim_set_keymap("n", "<Leader>E", ":Neotree reveal<CR>", { noremap = true })

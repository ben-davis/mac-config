-- Using telescope as all explorers suck with tabs
-- Configured in `jelescope.lua`
vim.api.nvim_set_keymap("n", "<Leader>e", ":Telescope file_browser path=%:p:h<CR>", { noremap = true })

vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

require("neo-tree").setup({
	buffers = {
		follow_current_file = {
			enabled = true,
		},
	},
})

vim.api.nvim_set_keymap("n", "<Leader>E", ":Neotree reveal<CR>", { noremap = true })

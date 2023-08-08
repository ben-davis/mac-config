vim.keymap.set("n", "<leader>k", ":DashWord<CR>", { noremap = true })
vim.keymap.set("n", "<space>k", ":Dash<CR>", { noremap = true })

require("dash").setup({
	file_type_keywords = {
		python = { "python3", "Django", "sqlalchemy", "pytest" },
		javascript = { "javascript", "nodejs", "lodash" },
		typescript = { "typescript", "javascript", "nodejs", "lodash" },
		typescriptreact = { "typescript", "javascript", "react", "tailwindcss", "lodash" },
		javascriptreact = { "javascript", "react", "tailwindcss", "lodash" },
		swift = { "swift", "apple" },
		objc = { "objc", "apple" },

		objcpp = { "objcpp", "apple" },
	},
})

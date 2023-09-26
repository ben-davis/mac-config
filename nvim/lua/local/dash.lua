vim.keymap.set("n", "<leader>k", ":DashWord<CR>", { noremap = true })
vim.keymap.set("n", "<space>k", ":Dash<CR>", { noremap = true })

require("dash").setup({
	file_type_keywords = {
		python = { "python3", "Django", "sqlalchemy", "pytest" },
		javascript = { "javascript", "nodejs", "lodash", "react", "reactnative" },
		typescript = { "typescript", "javascript", "nodejs", "lodash", "react", "reactnative" },
		typescriptreact = { "typescript", "javascript", "react", "tailwindcss", "lodash", "react", "reactnative" },
		javascriptreact = { "javascript", "react", "tailwindcss", "lodash", "react", "reactnative" },
		swift = { "swift", "apple" },
		objc = { "objc", "apple" },

		objcpp = { "objcpp", "apple" },
	},
})

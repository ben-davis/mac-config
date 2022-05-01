vim.keymap.set("n", "<leader>k", ":DashWord<CR>", { noremap = true })
vim.keymap.set("n", "<space>k", ":Dash<CR>", { noremap = true })

vim.g["dasht_filetype_docsets"] = {
	python = { "Django" },
	htmldjango = { "Django" },
	javascript = { "React" },
	typescript = { "React" },
	typescriptreact = { "React" },
	javascriptreact = { "React" },
}

vim.g["dasht_results_window"] = "vnew"

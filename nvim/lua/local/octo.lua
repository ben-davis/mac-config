require("octo").setup({
	mappings = {
		pull_request = {
			reload = "gr",
			open_in_browser = "gb",
			checkout_pr = "<space>zaazazazaz",
			merge_pr = "<space>zazazaza",
			list_commits = "<space>zaajasd",
			list_changed_files = "<space>zaasfasd",
		},
	},
})

vim.keymap.set("n", "<space>g", ":Octo actions<CR>", { noremap = true })

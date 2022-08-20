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

-- I have no idea why, but OctoEditable is bright pink, even though it should default to NormalFloat.
-- So I just reset it here, which seems to work.
vim.api.nvim_exec("hi! link OctoEditable NormalFloat", true)

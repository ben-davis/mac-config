require("octo").setup({
	mappings = {
		pull_request = {
			reload = "gr",
			open_in_browser = "gb",
			checkout_pr = "<space>zsdasdjasdaazazazaz",
			merge_pr = "<space>zazazazhasdasdasdasda",
			list_commits = "<space>zaajasgiguhanjmd",
			list_changed_files = "<space>zaasfaasdasd=isd",
		},
		review_diff = {
			select_next_entry = { lhs = "<tab>", desc = "move to previous changed file" },
			select_prev_entry = { lhs = "<S-tab>", desc = "move to next changed file" },
		},
		file_panel = {
			select_next_entry = { lhs = "<tab>", desc = "move to previous changed file" },
			select_prev_entry = { lhs = "<S-tab>", desc = "move to next changed file" },
		},
	},
})

vim.keymap.set("n", "<space>go", ":Octo actions<CR>", { noremap = true })

-- I have no idea why, but OctoEditable is bright pink, even though it should default to NormalFloat.
-- So I just reset it here, which seems to work.
vim.api.nvim_exec("hi! link OctoEditable NormalFloat", true)

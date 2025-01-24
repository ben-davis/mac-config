require("fzf-lua").setup({ "borderless-full" })

-- VIM Lists
vim.api.nvim_set_keymap("n", "<space>p", "<cmd>lua require('fzf-lua').git_files()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<space>f", "<cmd>lua require('telescope').live_grep_native()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<space>m", "<cmd>lua require('fzf-lua').oldfiles()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<space>l", "<cmd>lua require('fzf-lua').builtin()<CR>", { silent = true })
vim.api.nvim_set_keymap(
	"n",
	"<space>b",
	"<cmd>lua require('fzf-lua').buffers({ sort_mru = true, ignore_current_buffer = true })<CR>",
	{ silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<space>/",
	"<cmd>lua require('fzf-lua').current_buffer_fuzzy_find()<CR>",
	{ silent = true }
)
vim.api.nvim_set_keymap("n", "<space>q", "<cmd>lua require('fzf-lua').quickfix()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<space>r", "<cmd>lua require('fzf-lua').resume()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<space>t", "<cmd>lua require('fzf-lua').tabs()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<space>w", "<cmd>lua require('fzf-lua').spell_suggest()<CR>", { silent = true })

-- Git lists
vim.api.nvim_set_keymap("n", "<space>gb", "<cmd>lua require('fzf-lua').git_branches()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<space>gh", "<cmd>lua require('fzf-lua').git_bcommits()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<space>gc", "<cmd>lua require('fzf-lua').git_commits()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<space>gs", "<cmd>lua require('fzf-lua').git_status()<CR>", { silent = true })

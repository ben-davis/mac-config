local utils = require("telescope.utils")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")

require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				-- Make escape exit in insert mode as well
				-- ["<esc>"] = actions.close,
			},
		},
		layout_config = {
			horizontal = { width = 0.9999, height = 0.9999, preview_width = 0.5 },
		},
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
		},
		file_browser = {
			theme = "ivy",
			-- disables netrw and use telescope-file-browser in its place
			hijack_netrw = true,
			select_buffer = true,
		},
	},
})

-- require("telescope").load_extension("fzf")
require("telescope").load_extension("projects")
require("telescope").load_extension("tele_tabby")
require("telescope").load_extension("dap")
require("telescope").load_extension("file_browser")

-- Falls back to regular if not git directory
_G.project_files = function()
	local _, ret, _ = utils.get_os_command_output({ "git", "rev-parse", "--is-inside-work-tree" })
	if ret == 0 then
		builtin.git_files()
	else
		builtin.find_files()
	end
end

-- VIM Lists
vim.api.nvim_set_keymap("n", "<space>p", "<cmd>lua require('telescope.builtin').find_files()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<space>f", "<cmd>lua require('telescope.builtin').live_grep()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<space>m", "<cmd>lua require('telescope.builtin').oldfiles()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<space>l", "<cmd>lua require('telescope.builtin').builtin()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<space>b", "<cmd>lua require('telescope.builtin').buffers()<CR>", { silent = true })
vim.api.nvim_set_keymap(
	"n",
	"<space>/",
	"<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>",
	{ silent = true }
)
vim.api.nvim_set_keymap("n", "<space>q", "<cmd>lua require('telescope.builtin').quickfix()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<space>r", "<cmd>lua require('telescope.builtin').resume()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<space>P", "<cmd>Telescope projects<CR>", { silent = true })
vim.api.nvim_set_keymap(
	"n",
	"<space>t",
	"<cmd>lua require('telescope').extensions.tele_tabby.list{}<CR>",
	{ silent = true }
)
vim.api.nvim_set_keymap("n", "<space>w", "<cmd>lua require('telescope.builtin').spell_suggest()<CR>", { silent = true })

-- Git lists
vim.api.nvim_set_keymap("n", "<space>gb", "<cmd>lua require('telescope.builtin').git_branches()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<space>gh", "<cmd>lua require('telescope.builtin').git_bcommits()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<space>gc", "<cmd>lua require('telescope.builtin').git_commits()<CR>", { silent = true })

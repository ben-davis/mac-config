local utils = require("telescope.utils")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")

require("telescope").setup({
	defaults = {
		preview = false,
		mappings = {
			i = {
				-- Make escape exit in insert mode as well
				["<esc>"] = actions.close,
			},
		},
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
		},
		dash = {
			file_type_keywords = {
				python = "python3",
			},
		},
	},
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("project")
require("telescope").load_extension("tele_tabby")
require("telescope").load_extension("dap")

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
vim.api.nvim_set_keymap("n", "<space>p", "<cmd>lua project_files()<CR>", { silent = true })
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
vim.api.nvim_set_keymap("n", "<space>h", "<cmd>lua require('telescope.builtin').git_bcommits()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<space>q", "<cmd>lua require('telescope.builtin').quickfix()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<space>r", "<cmd>lua require('telescope.builtin').resume()<CR>", { silent = true })
vim.api.nvim_set_keymap(
	"n",
	"<space>P",
	"<cmd>lua require('telescope').extensions.project.project{}<CR>",
	{ silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<space>t",
	"<cmd>lua require('telescope').extensions.tele_tabby.list{}<CR>",
	{ silent = true }
)

-- Git signs
require("gitsigns").setup()

-- Setup autopairs
require("nvim-autopairs").setup({
	enable_check_bracket_line = false,
})

-- Location lists
require("trouble").setup()

-- Better UI for neovim built-ins
-- require("dressing").setup()

-- Zen mode
require("zen-mode").setup()
vim.keymap.set("n", "<leader>z", ":ZenMode<CR>", { silent = true, noremap = true })

-- Email
vim.g["himalaya_mailbox_picker"] = "telescope"
vim.g["himalaya_telescope_preview_enabled"] = 1

vim.keymap.set("n", "<leader>m", ":Himalaya<CR>", { silent = true, noremap = true })

-- Floaterm
local function toggle_floaterm()
	local cwd = vim.fn.getcwd(0, 0)
	local project = vim.fn.fnamemodify(cwd, ":t")

	local bufnr = vim.fn["floaterm#terminal#get_bufnr"](project)

	if bufnr > -1 then
		vim.api.nvim_command(bufnr .. "FloatermToggle")
	else
		vim.api.nvim_command(
			"FloatermNew --height=0.8 --width=0.9 --wintype=float --name="
				.. project
				.. " --title="
				.. project
				.. " --position=center"
		)
	end
end

vim.keymap.set({ "n", "t" }, "<leader>a", toggle_floaterm, { silent = true, noremap = true })
vim.keymap.set({ "n", "t" }, "<leader>f", ":FloatermToggle<CR>", { silent = true, noremap = true })

-- Git blame popup
-- The plugin doesn't need setup but I'm adding a comment so I have a reminder. The plugin sets <leader>gm as the map.

-- Whichkey
require("which-key").setup()

-- Floating goto previews
require("goto-preview").setup({
	default_mappings = true,
})

-- Leap
require("leap").add_default_mappings()

-- Copy to cliupboardA
require("osc52").setup({
	max_length = 0, -- Maximum length of selection (0 for no limit)
	silent = false, -- Disable message on successful copy
	trim = false, -- Trim surrounding whitespaces before copy
	tmux_passthrough = true, -- Use tmux passthrough (requires tmux: set -g allow-passthrough on)
})

-- LSP outline
require("outline").setup({
	outline_window = {
		position = "right",
		auto_jump = false,
		width = 14,
	},
	outline_items = {
		show_symbol_lineno = true,
	},
})
vim.keymap.set({ "n" }, "<leader>o", ":Outline<CR>", { silent = true, noremap = true })
vim.keymap.set({ "n" }, "<leader>O", ":OutlineFocus<CR>", { silent = true, noremap = true })

-- Diffview
vim.keymap.set({ "n" }, "<leader>h", ":DiffviewFileHistory<CR>", { silent = true, noremap = true })
vim.keymap.set({ "n" }, "<leader>H", ":DiffviewFileHistory %<CR>", { silent = true, noremap = true })
vim.keymap.set({ "n" }, "<leader>G", ":DiffviewOpen<CR>", { silent = true, noremap = true })

-- require("neorg").setup()

require("neo-zoom").setup()
vim.keymap.set("n", "<leader>Z", function()
	vim.cmd("NeoZoomToggle")
end, { silent = true, nowait = true })

require("diffview")
require("gitlab").setup()

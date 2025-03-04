-- -- Setup autopairs
-- require("nvim-autopairs").setup({
-- 	enable_check_bracket_line = false,
-- })

-- -- Location lists
-- require("trouble").setup()

-- -- Better UI for neovim built-ins
-- -- require("dressing").setup()

-- -- Zen mode
-- require("zen-mode").setup()
-- vim.keymap.set("n", "<leader>z", ":ZenMode<CR>", { silent = true, noremap = true })

-- -- Email
-- vim.g["himalaya_mailbox_picker"] = "telescope"
-- vim.g["himalaya_telescope_preview_enabled"] = 1

-- vim.keymap.set("n", "<leader>m", ":Himalaya<CR>", { silent = true, noremap = true })

-- -- Git blame popup
-- -- The plugin doesn't need setup but I'm adding a comment so I have a reminder. The plugin sets <leader>gm as the map.

-- -- Whichkey
-- require("which-key").setup()

-- -- Floating goto previews
-- require("goto-preview").setup({
-- 	default_mappings = true,
-- })

-- -- Leap
-- require("leap").add_default_mappings()

-- -- Copy to cliupboardA
-- require("osc52").setup({
-- 	max_length = 0, -- Maximum length of selection (0 for no limit)
-- 	silent = false, -- Disable message on successful copy
-- 	trim = false, -- Trim surrounding whitespaces before copy
-- 	tmux_passthrough = true, -- Use tmux passthrough (requires tmux: set -g allow-passthrough on)
-- })

-- -- LSP outline
-- require("outline").setup({
-- 	outline_window = {
-- 		position = "right",
-- 		auto_jump = false,
-- 		width = 14,
-- 	},
-- 	outline_items = {
-- 		show_symbol_lineno = true,
-- 	},
-- })
-- vim.keymap.set({ "n" }, "<leader>o", ":Outline<CR>", { silent = true, noremap = true })
-- vim.keymap.set({ "n" }, "<leader>O", ":OutlineFocus<CR>", { silent = true, noremap = true })

require("obsidian").setup({
	workspaces = {
		{
			name = "Notes",
			path = "~/Google Drive/My Drive/Notes/",
		},
		{
			name = "Stripe",
			path = "~/Google Drive/My Drive/Stripe/",
		},
	},
	picker = {
		name = "fzf-lua",
	},
	daily_notes = {
		-- Optional, if you keep daily notes in a separate directory.
		folder = "daily",
	},
	-- see below for full list of options 👇
})

vim.keymap.set("n", "<leader>on", function()
	vim.cmd("ObsidianNew")
end, { silent = true, nowait = true, desc = "New" })

vim.keymap.set("n", "<leader>op", function()
	vim.cmd("ObsidianQuickSwitch")
end, { silent = true, nowait = true, desc = "Find file" })

vim.keymap.set("n", "<leader>of", function()
	vim.cmd("ObsidianSearch")
end, { silent = true, nowait = true , desc = "Grep"})

vim.keymap.set("n", "<leader>ot", function()
	vim.cmd("ObsidianToday")
end, { silent = true, nowait = true, desc = "Today" })

vim.keymap.set("n", "<leader>ow", function()
	vim.cmd("ObsidianWorkspace")
end, { silent = true, nowait = true, desc = "Workspace" })

vim.keymap.set("n", "<leader>od", function()
	vim.cmd("ObsidianDailies")
end, { silent = true, nowait = true, desc = "List dailies" })


-- require("neo-zoom").setup()
-- vim.keymap.set("n", "<leader>Z", function()
-- 	vim.cmd("NeoZoomToggle")
-- end, { silent = true, nowait = true })

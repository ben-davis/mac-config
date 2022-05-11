-- Git signs
require("gitsigns").setup()

-- Easier window movement
require("nvim-window").setup({
	-- The characters available for hinting windows.
	chars = {
		"0",
		"1",
		"2",
		"3",
		"4",
		"5",
		"6",
		"7",
		"8",
		"9",
		"a",
		"b",
		"c",
		"d",
		"e",
		"f",
		"g",
		"h",
		"i",
		"j",
		"k",
		"l",
		"m",
		"n",
		"o",
	},
})

vim.keymap.set("n", "<leader>w", ":lua require('nvim-window').pick()<CR>", { silent = true, noremap = true })

-- Setup autopairs
require("nvim-autopairs").setup({
	enable_check_bracket_line = false,
})

-- Zen mode
require("zen-mode").setup()
vim.keymap.set("n", "<leader>z", ":ZenMode<CR>", { silent = true, noremap = true })

-- Email
vim.g["himalaya_mailbox_picker"] = "telescope"
vim.g["himalaya_telescope_preview_enabled"] = 1

vim.keymap.set("n", "<leader>m", ":Himalaya<CR>", { silent = true, noremap = true })

-- Floaterm
local function toggle_floaterm()
	local is_open = vim.fn["floaterm#window#find"]()
	if is_open > 0 then
		vim.api.nvim_command("FloatermToggle term")
	else
		vim.api.nvim_command("FloatermNew --height=0.8 --width=0.9 --wintype=float --title=term --position=center")
	end
end
vim.keymap.set("n", "<leader>m", toggle_floaterm, { silent = true, noremap = true })

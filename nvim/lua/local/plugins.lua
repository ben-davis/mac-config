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

-- Git blame popup
-- The plugin doesn't need setup but I'm adding a comment so I have a reminder. The plugin sets <leader>gm as the map.

-- Whichkey
require("which-key").setup()

-- Floating goto previews
require("goto-preview").setup({
  default_mappings = true
})

-- Run requests
vim.keymap.set("n", "<leader>r", "<Plug>RestNvim", { silent = true, noremap = true })
require("rest-nvim").setup({
  result = {
    formatters = {
      json = "jq",
      vnd = "jq",
      html = function(body)
        return vim.fn.system({"tidy", "-i", "-q", "-"}, body)
      end
    }
  }
})

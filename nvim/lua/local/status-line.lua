local gps = require("nvim-gps")

gps.setup()

local symbol = function()
	if gps.is_available() then
		return gps.get_location()
	end

	return ""
end

-- Monkey patch lualine's tab module to use a custom label
local Tab = require("lualine.components.tabs.tab")
function Tab:label()
	local cwd = vim.fn.getcwd(1, self.tabnr)
	local project = vim.fn.fnamemodify(cwd, ":t")

	return project
end

local function file_path()
	return vim.fn.expand("%:p:.")
end

-- The lualine colors provided by tokyonight
local config = require("tokyonight.config")
local colors = require("tokyonight.colors").setup(config)

local setup = function()
	require("lualine").setup({
		options = {
			icons_enabled = true,
			theme = "tokyonight",
			component_separators = { left = "|", right = "|" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = { "NvimTree" },
		},
		sections = {
			lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
			lualine_b = { "filename" },
			lualine_c = {},
			lualine_x = {},
			lualine_y = { symbol },
			lualine_z = {
				{ "location", separator = { right = "" }, left_padding = 2 },
			},
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { "filename" },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {
			lualine_a = { { file_path, color = { bg = colors.bg_statusline, fg = colors.comment }, padding = 3 } },
			lualine_b = {},
			lualine_c = {},
			lualine_x = { "diff" },
			lualine_y = { "branch" },
			lualine_z = { { "tabs", mode = 1 } },
		},
		extensions = {},
	})
end

setup()

return { setup = setup }

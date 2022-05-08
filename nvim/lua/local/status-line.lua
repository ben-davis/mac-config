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
local theme = require("lualine.themes.tokyonight")

theme.inactive.a = { bg = colors.fg_gutter, fg = colors.blue }

local setup = function()
	require("lualine").setup({
		options = {
			icons_enabled = true,
			theme = theme,
			component_separators = { left = "|", right = "|" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = { "NvimTree" },
		},
		sections = {
			lualine_a = { { "mode", right_padding = 2, separator = { right = "" } } },
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_y = { { symbol, separator = { left = "" } } },
			lualine_z = {
				{ "location", left_padding = 2 },
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
			lualine_y = {
				{ "branch", color = { bg = colors.bg_statusline, fg = colors.blue }, separators = { left = "" } },
			},
			lualine_z = { { "tabs", mode = 1 } },
		},
		extensions = {},
	})
end

setup()

return { setup = setup }

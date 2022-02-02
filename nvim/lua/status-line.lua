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
	local tabooName = vim.fn.TabooTabName(self.tabnr)
	if tabooName ~= "" then
		return tabooName
	end

	local buflist = vim.fn.tabpagebuflist(self.tabnr)
	local winnr = vim.fn.tabpagewinnr(self.tabnr)
	local bufnr = buflist[winnr]
	local file = vim.api.nvim_buf_get_name(bufnr)
	local dir = vim.fn.fnamemodify(file, ":p:h:t")

	return dir
end

local setup = function()
	require("lualine").setup({
		options = {
			icons_enabled = true,
			theme = "tokyonight",
			component_separators = { left = "|", right = "|" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = { "NvimTree" },
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = {},
			lualine_c = { "filename" },
			lualine_x = {},
			lualine_y = { symbol },
			lualine_z = { "location" },
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
			lualine_a = {},
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

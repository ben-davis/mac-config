local gps = require("nvim-gps")

gps.setup()

local symbol = function()
  if gps.is_available() then
    return gps.get_location()
  end

  return ""
end

local setup = function()
  require "lualine".setup {
    options = {
      icons_enabled = true,
      theme = "tokyonight",
      component_separators = {left = "|", right = "|"},
      section_separators = {left = "", right = ""},
      disabled_filetypes = {"NvimTree"}
    },
    sections = {
      lualine_a = {"mode"},
      lualine_b = {},
      lualine_c = {"filename"},
      lualine_x = {},
      lualine_y = {symbol},
      lualine_z = {"location"}
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {"filename"},
      lualine_x = {"location"},
      lualine_y = {},
      lualine_z = {}
    },
    tabline = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {"diff"},
      lualine_y = {"branch"},
      lualine_z = {"tabs"}
    },
    extensions = {}
  }
end

setup()

return {setup = setup}

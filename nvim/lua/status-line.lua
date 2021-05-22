-- local colors = require('galaxyline.colors')

-- require('galaxyline').section.left[1]= {
--   FileSize = {
--     provider = 'GetLspClient',
--     condition = function()
--       if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
--         return true
--       end
--       return false
--       end,
--     icon = '   ',
--     highlight = {colors.green,colors.purple},
--     separator = '',
--     separator_highlight = {colors.purple,colors.darkblue},
--   }
-- }
local setup = function(theme)
  require'lualine'.setup {
    options = {
      icons_enabled = true,
      theme = theme,
      component_separators = {'|', '|'},
      section_separators = {'', ''},
      disabled_filetypes = {'NvimTree'}
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch'},
      lualine_c = {'filename'},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {'location'}
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {'filename'},
      lualine_x = {'location'},
      lualine_y = {},
      lualine_z = {}
    },
    tabline = {},
    extensions = {}
  }
end

setup("ayu_dark")

return {setup = setup}

local lsp_symbol = function() 
  if #vim.lsp.buf_get_clients() > 0 then
    return vim.b.lsp_current_function
  end

  return ''
end

local setup = function(theme)
  require'lualine'.setup {
    options = {
      icons_enabled = true,
      theme = 'tokyonight',
      component_separators = { left = '|', right = '|'},
      section_separators = { left = '', right = ''},
      disabled_filetypes = {'NvimTree'}
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch'},
      lualine_c = {'filename'},
      lualine_x = {},
      lualine_y = {lsp_symbol},
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

setup("auto")

return {setup = setup}

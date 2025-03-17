return { {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.o.background = "dark"
    vim.g["tokyonight_style"] = "night"
    vim.g["tokyonight_lualine_bold"] = true
    vim.g["tokyonight_italic_functions"] = 1
    vim.g["tokyonight_italic_keywords"] = 1
    vim.g["tokyonight_dark_sidebar"] = "false"
    vim.g["tokyonight_transparent_sidebar"] = 1

    -- Makes colors appear correctly when within tmux
    vim.o.termguicolors = true

    require("tokyonight").setup({
      transparent = false,
      hide_inactive_statusline = true,
      dim_inactive = true,

      on_colors = function(colors)
        colors.bg_statusline = nil
      end,
      -- Borderless telescope
      on_highlights = function(hl, c)
        local prompt = "#2d3149"
        hl.TelescopeNormal = {
          -- bg = c.bg_dark,
          fg = c.fg_dark,
        }
        hl.TelescopeBorder = {
          -- bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.TelescopePromptNormal = {
          -- bg = prompt,
        }
        hl.TelescopePromptBorder = {
          -- bg = prompt,
          fg = prompt,
        }
        hl.TelescopePromptTitle = {
          -- bg = prompt,
          fg = prompt,
        }
        hl.TelescopePreviewTitle = {
          -- bg = c.bg_dark,
          fg = c.bg_dark,
        }
        hl.TelescopeResultsTitle = {
          -- bg = c.bg_dark,
          fg = c.bg_dark,
        }
      end,
    })

    -- Set after so that the transparent stuff is set properly
    vim.api.nvim_command("colorscheme tokyonight-moon")
    -- vim.api.nvim_command("colorscheme catppuccin")
  end
} }

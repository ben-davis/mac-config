return {
  {
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
      })

      -- Set after so that the transparent stuff is set properly
      vim.api.nvim_command("colorscheme tokyonight-moon")
      -- vim.api.nvim_command("colorscheme catppuccin")
    end,
  },
}

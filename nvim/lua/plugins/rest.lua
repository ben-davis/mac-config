return { {
  "rest-nvim/rest.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "http")
    end,
  },
  enabled = vim.loop.os_uname().sysname ~= "Linux",
  keys = {
    { "<leader>R", ":Rest run<CR>", mode = "n" }
  }
} }

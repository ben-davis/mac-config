return { {
  "rest-nvim/rest.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "http")
    end,
  },
  config = function()
    require('rest-nvim').setup({
      encode_url = true,
    })
  end,
  ft = "http",
  enabled = vim.loop.os_uname().sysname ~= "Linux",
  keys = {
    { "<leader>rr", ":Rest run<CR>",        mode = "n" },
    { "<leader>re", ":Rest env select<CR>", mode = "n" }
  }
} }

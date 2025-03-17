return { {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      input = { enabled = true },
      notifier = { enabled = true },
      -- zen = {}
    },
    keys = {
      { "<space>h", function() require("snacks").notifier.show_history() end, desc = "Snacks | Notifier | Show History" },
    }
  }
} }

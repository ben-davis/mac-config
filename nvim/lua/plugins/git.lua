return {
  {
    "sindrets/diffview.nvim",
    options = {
      git_cmd = "/usr/local/bin/git-wrapper",
    },
    keys = {
      { "<leader>gl", ":DiffviewFileHistory<CR>", desc = "Repo history" },
      { "<leader>gh", ":DiffviewFileHistory --follow %<CR>", desc = "File history" },
      { "<leader>gh", "<Esc><Cmd>'<,'>DiffviewFileHistory --follow<CR>", mode = "v", desc = "Range history" },
      { "<leader>g.", "<Cmd>.DiffviewFileHistory --follow<CR>", desc = "Line history" },
      { "<leader>gd", ":DiffviewOpen <CR>", desc = "Diff worktree" },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
  },
  {
    "NeogitOrg/neogit",
    config = function()
      -- Neogit
      vim.keymap.set({ "n" }, "<leader>gs", ":Neogit <CR>", { silent = true, noremap = true, desc = "Git status" })

      vim.keymap.set("n", "<leader>ga", function()
        local file = vim.fn.expand("%:p")
        local cmd = string.format('git add -N "%s"', file)
        local output = vim.fn.system(cmd)
        if vim.v.shell_error == 0 then
          vim.notify("File added to Git tracking", vim.log.levels.INFO)
        else
          vim.notify("Failed to add file to Git tracking: " .. output, vim.log.levels.ERROR)
        end
      end, { desc = "[G]it [A]dd Current File" })

      require("neogit").setup({
        disable_hint = true,
        filewatcher = {
          enabled = false,
        },
        process_spinner = true,
        auto_refresh = false,
      })
    end,
  },
  -- {
  --   "rhysd/git-messenger.vim",
  --   config = function()
  --     -- Git messenger (blame)
  --     vim.g["git_messenger_no_default_mappings"] = true
  --     vim.keymap.set(
  --       { "n" },
  --       "<leader>gm",
  --       "<Plug>(git-messenger)",
  --       { silent = true, noremap = true, desc = "Git blame" }
  --     )
  --   end,
  -- },
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = true,
  },
}

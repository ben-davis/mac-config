return {
  {
    'sindrets/diffview.nvim',
    config = function()
      -- Diffview
      vim.keymap.set(
        { "n" },
        "<leader>gl",
        ":DiffviewFileHistory<CR>",
        { silent = true, noremap = true, desc = "Repo history" }
      )
      vim.keymap.set(
        { "n" },
        "<leader>gh",
        ":DiffviewFileHistory --follow %<CR>",
        { silent = true, noremap = true, desc = "File history" }
      )
      vim.keymap.set(
        { "v" },
        "<leader>gh",
        "<Esc><Cmd>'<,'>DiffviewFileHistory --follow<CR>",
        { silent = true, noremap = true, desc = "Range history" }
      )
      vim.keymap.set(
        { "n" },
        "<leader>g.",
        "<Cmd>.DiffviewFileHistory --follow<CR>",
        { silent = true, noremap = true, desc = "Line history" }
      )
      vim.keymap.set({ "n" }, "<leader>gd", ":DiffviewOpen <CR>",
        { silent = true, noremap = true, desc = "Diff worktree" })
    end
  },
  {
    "lewis6991/gitsigns.nvim"
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

      require('neogit').setup({
        disable_hint = true,
        filewatcher = {
          enabled = false,
        },
        process_spinner = true,
        auto_refresh = false,
      })
    end
  },
  {
    'rhysd/git-messenger.vim',
    config = function()
      -- Git messenger (blame)
      vim.g["git_messenger_no_default_mappings"] = true
      vim.keymap.set({ "n" }, "<leader>gm", "<Plug>(git-messenger)",
        { silent = true, noremap = true, desc = "Git blame" })
    end
  }
}

return {
  {
    'stevearc/oil.nvim',
    config = function()
      require("oil").setup({
        delete_to_trash = true,
        use_default_keymaps = false,
        keymaps = {
          ["g?"] = { "actions.show_help", mode = "n" },
          ["<CR>"] = "actions.select",
          ["<C-s>"] = { "actions.select", opts = { vertical = true } },
          ["<C-v>"] = { "actions.select", opts = { horizontal = true } },
          ["<C-t>"] = { "actions.select", opts = { tab = true } },
          ["<C-p>"] = "actions.preview",
          ["<C-c>"] = { "actions.close", mode = "n" },
          ["R"] = "actions.refresh",
          ["<Backspace>"] = { "actions.parent", mode = "n" },
          ["_"] = { "actions.open_cwd", mode = "n" },
          ["`"] = { "actions.cd", mode = "n" },
          ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
          ["gs"] = { "actions.change_sort", mode = "n" },
          ["gx"] = "actions.open_external",
          ["g."] = { "actions.toggle_hidden", mode = "n" },
          ["g\\"] = { "actions.toggle_trash", mode = "n" },
        },
      })

      vim.api.nvim_set_keymap("n", "<Leader>e", ":Oil %:h<CR>", { noremap = true })
    end
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    config = function()
      require("neo-tree").setup({
        -- Enabling git creates tons of UI lag
        enable_git_status = false,
        enable_diagnostics = false,
        buffers = {
          follow_current_file = {
            enabled = true,
          },
        },
      })

      vim.api.nvim_set_keymap("n", "<Leader>E", ":Neotree reveal<CR>", { noremap = true })
    end
  }
}

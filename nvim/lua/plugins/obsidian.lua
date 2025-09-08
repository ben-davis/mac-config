return {
  {
    "epwalsh/obsidian.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local workspaces = {}

      local note_dirs = {
        { "Notes", "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Notes/" },
        { "Stripe", "~/Google Drive/My Drive/Stripe/" },
      }

      for _, dir in ipairs(note_dirs) do
        local name, path = dir[1], dir[2]

        if vim.fn.isdirectory(vim.fn.expand(path)) > 0 then
          table.insert(workspaces, {
            name = name,
            path = path,
          })
        end
      end

      if next(workspaces) ~= nil then
        require("obsidian").setup({
          workspaces = workspaces,
          picker = {
            name = "fzf-lua",
          },
          daily_notes = {
            -- Optional, if you keep daily notes in a separate directory.
            folder = "daily",
          },
          -- see below for full list of options 👇
        })
      end

      vim.keymap.set("n", "<leader>on", function()
        vim.cmd("ObsidianNew")
      end, { silent = true, nowait = true, desc = "New" })

      vim.keymap.set("n", "<leader>op", function()
        vim.cmd("ObsidianQuickSwitch")
      end, { silent = true, nowait = true, desc = "Find file" })

      vim.keymap.set("n", "<leader>of", function()
        vim.cmd("ObsidianSearch")
      end, { silent = true, nowait = true, desc = "Grep" })

      vim.keymap.set("n", "<leader>ot", function()
        vim.cmd("ObsidianToday")
      end, { silent = true, nowait = true, desc = "Today" })

      vim.keymap.set("n", "<leader>ow", function()
        vim.cmd("ObsidianWorkspace")
      end, { silent = true, nowait = true, desc = "Workspace" })

      vim.keymap.set("n", "<leader>od", function()
        vim.cmd("ObsidianDailies")
      end, { silent = true, nowait = true, desc = "List dailies" })
    end,
  },
}

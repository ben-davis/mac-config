local workspaces = {}

local note_dirs = {
  { "Notes",  "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Notes/" },
  { "Notes",  "~/Google Drive/My Drive/Notes/" },
  { "Stripe", "~/Google Drive/My Drive/Stripe/" },
}


for _, dir in ipairs(note_dirs) do
  local name, path = dir[1], dir[2]

  if vim.fn.isdirectory(path) > 0 then
    workspaces.insert({
      name = name,
      path = path,
    })
  end
end


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

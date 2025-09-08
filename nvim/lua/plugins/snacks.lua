return {
  {
    {
      "folke/snacks.nvim",
      priority = 1000,
      lazy = false,
      opts = {
        input = { enabled = true },
        notifier = { enabled = true },
        zen = { enabled = true },
      },
      keys = {
        {
          "<space>h",
          function()
            require("snacks").notifier.show_history()
          end,
          desc = "Snacks | Notifier | Show History",
        },

        { "<space>:", "<CMD>lua Snacks.picker.command_history()<CR>", desc = "Command History" },
        { "<space>p", "<CMD>lua Snacks.picker.smart()<CR>", desc = "Files" },
        { "<space>P", "<CMD>lua Snacks.picker.git_files()<CR>", desc = "Git files" },
        { "<space>C", "<CMD>lua Snacks.picker.commands()<CR>", desc = "Neovim commands" },
        { "<space>f", "<CMD>lua Snacks.picker.grep()<CR>", desc = "Grep cwd" },
        {
          "<space>*",
          "<CMD>lua Snacks.picker.grep_word()<CR>",
          desc = "Grep word under cursor",
        },
        { "<space>m", "<CMD>lua Snacks.picker.recent()<CR>", desc = "Recent files" },
        { "<space>l", "<CMD>lua Snacks.picker.pickers()<CR>", desc = "All pickers" },
        { "<space>b", "<CMD>lua Snacks.picker.buffers({current = false})<CR>", desc = "All pickers" },
        { "<space>/", "<CMD>lua Snacks.picker.lines()<CR>", desc = "Buffer search" },
        { "<space>q", "<CMD>lua Snacks.picker.qflist()<CR>", desc = "Quickfix" },
        { "<space>r", "<CMD>lua Snacks.picker.resume()<CR>", desc = "Resume" },
        { "<space>w", "<CMD>lua Snacks.picker.spelling()<CR>", desc = "Spelling" },

        { "<space>gb", "<CMD>lua Snacks.picker.git_branches()<CR>", desc = "[G]it [B]ranches" },
        { "<space>gs", "<CMD>lua Snacks.picker.git_status()<CR>", desc = "[G]it [S]tatus" },
        { "<space>gf", "<CMD>lua Snacks.picker.git_grep()<CR>", desc = "[G]it [F]ind" },
        { "<space>gd", "<CMD>lua Snacks.picker.git_diff()<CR>", desc = "[G]it [D]iff" },
        { "<space>glr", "<CMD>lua Snacks.picker.log()<CR>", desc = "[G]it [L]og [R]epo" },
        { "<space>glf", "<CMD>lua Snacks.picker.log({current_file = true})<CR>", desc = "[G]it [L]og [F]ile" },
        { "<space>gll", "<CMD>lua Snacks.picker.log({current_line = true})<CR>", desc = "[G]it [L]og [L]ine" },

        {
          "<space>d",
          "<CMD>lua Snacks.picker.diagnostics_buffer()<CR>",
          desc = "Buffer [D]iagnostics",
        },
        {
          "<space>D",
          "<CMD>lua Snacks.picker.diagnostics()<CR>",
          desc = "Workspace [D]iagnostics",
        },

        { "<leader>z", "<CMD>lua Snacks.zen.zen()<CR>", desc = "[z]en" },
        { "<leader>Z", "<CMD>lua Snacks.zen.zoom()<CR>", desc = "[Z]oom" },
      },
    },
  },
}

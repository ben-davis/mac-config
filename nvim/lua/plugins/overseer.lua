return {
  { -- Task runner
    "stevearc/overseer.nvim",
    opts = {
      templates = { "builtin" },
      template_dirs = { "overseer.template" },
      default_neotest = {
        { "on_complete_notify", on_change = true },
        "default",
      },
    },
    keys = {
      { "<leader>ot", "<cmd>OverseerToggle<CR>", desc = "[O]verseer [T]oggle" },
      { "<leader>or", "<cmd>OverseerRun<CR>", desc = "[O]verseer [R]un" },
      { "<leader>oq", "<cmd>OverseerQuickAction<CR>", desc = "[O]verseer [Q]uick action" },
      { "<leader>oa", "<cmd>OverseerTaskAction<CR>", desc = "[O]verseer task [A]ction" },
    },
  },
}

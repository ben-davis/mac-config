local dap = require("dap")
local dapui = require("dapui")

-- This causes DAP to use `uv` to find `debugpy`. The python file being executed will be ran with the python executable
-- based on the project (dap-python has this logic, as does neo-test/python)
require("dap-python").setup("uv")
require("dap-ruby").setup()
require("dapui").setup()
require("nvim-dap-virtual-text").setup({})

dap.defaults.fallback.terminal_win_cmd = "10vsplit new | set winfixwidth"

-- Automatically open dapui when a debug session is connected
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

-- Keymaps
vim.api.nvim_set_keymap("n", "<leader>D", "<cmd>lua require('dapui').toggle()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>dc", "<cmd>lua require('dap').continue()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>ds", "<cmd>lua require('dap').step_into()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>dn", "<cmd>lua require('dap').step_over()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>do", "<cmd>lua require('dap').step_out()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>du", "<cmd>lua require('dap').up()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>dd", "<cmd>lua require('dap').down()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>dr", "<cmd>lua require('dap').run_last()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>dk", "<cmd>lua require('dap.ui.variables').visual_hover()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>dx", "<cmd>lua require('dap').close()<CR>", { silent = true })
vim.api.nvim_set_keymap(
  "n",
  "<leader>dK",
  "<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>",
  { silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>dl",
  "<cmd>lua require'telescope'.extensions.dap.commands{}<CR>",
  { silent = true }
)
vim.api.nvim_set_keymap("n", "<leader>df", "<cmd>lua require'telescope'.extensions.dap.frames{}<CR>", { silent = true })

-- Icons
local icons = {
  Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
  Breakpoint = " ",
  BreakpointCondition = " ",
  BreakpointRejected = { " ", "DiagnosticError" },
  LogPoint = ".>",
}

for name, sign in pairs(icons) do
  sign = type(sign) == "table" and sign or { sign }
  vim.fn.sign_define(
    "Dap" .. name,
    { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
  )
end

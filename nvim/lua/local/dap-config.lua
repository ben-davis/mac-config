local dap = require("dap")
local dapui = require("dapui")

-- dap.adapters.python = {
-- 	type = "executable",
-- 	command = "python",
-- 	args = { "-m", "debugpy.adapter" },
-- }

-- dap.adapters.pythonServer = {
-- 	type = "server",
-- 	host = "127.0.0.1",
-- 	port = "5678",
-- }

dap.adapters.python = function(cb, config)
  if config.request == "attach" then
    local port = (config.connect or config).port
    cb({
      type = "server",
      port = assert(port, "`connect.port` is required for a python `attach` configuration"),
      host = (config.connect or config).host or "127.0.0.1",
      options = {
        source_filetype = "python",
      },
    })
  else
    cb({
      type = "executable",
      command = "python",
      args = { "-m", "debugpy.adapter" },
      options = {
        source_filetype = "python",
      },
    })
  end
end

dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "System",
    program = "${file}",
    -- Opens a terminal connected to the running python process so we can see output
    console = "integratedTerminal",
  },
  {
    type = "python",
    request = "attach",
    name = "Tests",
    port = 5679,
    justMyCode = false,
  },
  {
    type = "python",
    request = "attach",
    name = "Rupa - Server",
    port = 5678,
    pathMappings = {
      {
        localRoot = "/Users/ben/dev/git/rupalabs/server",
        remoteRoot = "/app",
      },
    },
  },
  {
    type = "python",
    request = "attach",
    name = "Rupa - Tests",
    port = 5679,
    pathMappings = {
      {
        localRoot = "/Users/ben/dev/git/rupalabs/server",
        remoteRoot = "/app",
      },
    },
  },
  {
    type = "python",
    request = "attach",
    name = "Adventure Text",
    pathMappings = {
      {
        localRoot = "/Users/ben/dev/git/adventure-text-api",
        remoteRoot = "/code",
      },
    },
  },
}

-- Node

dap.adapters.node2 = {
  type = "executable",
  command = "node",
  args = { os.getenv("HOME") .. "/dev/git/vscode-node-debug2/out/src/nodeDebug.js" },
}

dap.configurations.typescript = {
  {
    name = "Launch",
    type = "node2",
    request = "launch",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",
  },
}

dap.defaults.fallback.terminal_win_cmd = "10vsplit new | set winfixwidth"

require("dapui").setup()
require("nvim-dap-virtual-text").setup()

-- Automatically open dapui when a debug session is connected
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

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
vim.api.nvim_set_keymap(
  "n",
  "<leader>dK",
  "<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>",
  { silent = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>dx",
  "<cmd>lua require'telescope'.extensions.dap.commands{}<CR>",
  { silent = true }
)

vim.api.nvim_set_keymap("n", "<leader>df", "<cmd>lua require'telescope'.extensions.dap.frames{}<CR>", { silent = true })

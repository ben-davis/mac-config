local dap = require('dap')

dap.adapters.python = {
	type = 'server';
  host = '127.0.0.1';
  port = '5678';
}

dap.adapters.pythonTest = {
	type = 'executable';
  host = '127.0.0.1';
  port = '5678';
}

dap.configurations.python = {
  {
    type = 'python';
    request = 'attach';
    name = "Rupa";
    pathMappings = {
        {
          localRoot = "/Users/ben/dev/git/rupalabs/server";
          remoteRoot = "/app";
        }
    };
  },
  {
    type = 'python';
    request = 'attach';
    name = "Adventure Text";
    pathMappings = {
        {
          localRoot = "/Users/ben/dev/git/adventure-text-api";
          remoteRoot = "/code";
        }
    };
  },
}

require("dapui").setup()

vim.api.nvim_set_keymap("n", "<leader>D", "<cmd>lua require('dapui').toggle()<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<leader>dc", "<cmd>lua require('dap').continue()<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<leader>ds", "<cmd>lua require('dap').step_into()<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<leader>dn", "<cmd>lua require('dap').step_over()<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<leader>do", "<cmd>lua require('dap').step_out()<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<leader>du", "<cmd>lua require('dap').up()<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<leader>dd", "<cmd>lua require('dap').down()<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<leader>dr", "<cmd>lua require('dap').repl.open()<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<leader>dk", "<cmd>lua require('dap.ui.variables').hover()<CR>", {silent = true})

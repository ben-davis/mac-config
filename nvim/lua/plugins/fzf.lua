return {
  {
    'ibhagwan/fzf-lua',
    dependencies = {
      'kyazdani42/nvim-web-devicons'
    },
    config = function()
      require("fzf-lua").setup({ "borderless-full" })

      -- DAP
      vim.api.nvim_set_keymap(
        "n",
        "<leader>dl",
        "<cmd>lua require('fzf-lua').dap_commands()<CR>",
        { silent = true }
      )
      vim.api.nvim_set_keymap("n", "<leader>df", "<cmd>lua require('fzf-lua').dap_commands()<CR>",
        { silent = true })
    end
  } }

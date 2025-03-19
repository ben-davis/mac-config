return {
  {
    'ibhagwan/fzf-lua',
    dependencies = {
      'kyazdani42/nvim-web-devicons'
    },
    config = function()
      require("fzf-lua").setup({ "borderless-full" })

      -- -- Falls back to regular if not git directory
      -- _G.project_files = function()
      -- 	local _, ret, _ = utils.get_os_command_output({ "git", "rev-parse", "--is-inside-work-tree" })
      -- 	if ret == 0 then
      -- 		fzf_lua.git_files()
      -- 	else
      -- 		fzf_lua.find_files()
      -- 	end
      -- end

      local function opts(desc)
        return { noremap = true, silent = true, desc = desc or "" }
      end

      -- VIM Lists
      vim.api.nvim_set_keymap("n", "<space>p", "<cmd>lua require('fzf-lua').files()<CR>", opts("Git files"))
      vim.api.nvim_set_keymap("n", "<space>P", "<cmd>lua require('fzf-lua').git_files()<CR>", opts("Non-git files"))
      vim.api.nvim_set_keymap("n", "<space>C", "<cmd>lua require('fzf-lua').commands()<CR>", opts("Neovim commands"))
      vim.api.nvim_set_keymap("n", "<space>f", "<cmd>lua require('fzf-lua').live_grep_glob()<CR>", opts("Grep cwd"))
      vim.api.nvim_set_keymap("n", "<space>*", "<cmd>lua require('fzf-lua').grep_cword()<CR>",
        opts("Grep word under cursor"))
      vim.api.nvim_set_keymap("n", "<space>m", "<cmd>lua require('fzf-lua').oldfiles()<CR>", opts("Recent files"))
      vim.api.nvim_set_keymap("n", "<space>l", "<cmd>lua require('fzf-lua').builtin()<CR>", opts("Builtins"))
      vim.api.nvim_set_keymap(
        "n",
        "<space>b",
        "<cmd>lua require('fzf-lua').buffers({ sort_mru = true, ignore_current_buffer = true })<CR>",
        opts("Buffers")
      )
      vim.api.nvim_set_keymap(
        "n",
        "<space>/",
        "<cmd>lua require('fzf-lua').grep_curbuf()<CR>",
        opts("Buffer search")
      )
      vim.api.nvim_set_keymap("n", "<space>q", "<cmd>lua require('fzf-lua').quickfix()<CR>", opts("Quickfix"))
      vim.api.nvim_set_keymap("n", "<space>r", "<cmd>lua require('fzf-lua').resume()<CR>", opts("Resume"))
      vim.api.nvim_set_keymap("n", "<space>t", "<cmd>lua require('fzf-lua').tabs()<CR>", opts("Tabs"))
      vim.api.nvim_set_keymap("n", "<space>w", "<cmd>lua require('fzf-lua').spell_suggest()<CR>",
        opts("Spell suggestions"))

      -- Git lists
      vim.api.nvim_set_keymap("n", "<space>gb", "<cmd>lua require('fzf-lua').git_branches()<CR>", opts("Git branches"))
      vim.api.nvim_set_keymap(
        "n",
        "<space>gh",
        "<cmd>lua require('fzf-lua').git_bcommits()<CR>",
        opts("Git commits for buffer")
      )
      vim.api.nvim_set_keymap("n", "<space>gc", "<cmd>lua require('fzf-lua').git_commits()<CR>", opts("Git commits"))
      vim.api.nvim_set_keymap("n", "<space>gs", "<cmd>lua require('fzf-lua').git_status()<CR>", opts("Git status"))

      -- LSP
      vim.api.nvim_set_keymap(
        "n",
        "<space>ci",
        "<cmd>lua require('fzf-lua').lsp_incoming_calls()<CR>",
        opts("LSP incoming calls")
      )
      vim.api.nvim_set_keymap(
        "n",
        "<space>co",
        "<cmd>lua require('fzf-lua').lsp_outgoing_calls()<CR>",
        opts("LSP outgoing calls")
      )
      vim.api.nvim_set_keymap(
        "n",
        "<space>s",
        "<cmd>lua require('fzf-lua').lsp_workspace_symbols()<CR>",
        opts("LSP workspace symbols")
      )
      vim.api.nvim_set_keymap(
        "n",
        "<space>o",
        "<cmd>lua require('fzf-lua').lsp_document_symbols()<CR>",
        opts("LSP document symbols")
      )

      vim.api.nvim_set_keymap(
        "n",
        "<space>d",
        "<cmd>lua require('fzf-lua').diagnostics_document()<CR>",
        opts("LSP buffer diagnostics")
      )
      vim.api.nvim_set_keymap(
        "n",
        "<space>D",
        "<cmd>lua require('fzf-lua').diagnostics_workspace<CR>",
        opts("LSP diagnostics")
      )

      vim.api.nvim_set_keymap(
        "n",
        "gr",
        "<cmd>lua require('fzf-lua').lsp_references({ includeDeclaration = false })<CR>",
        opts("LSP references")
      )
      vim.api.nvim_set_keymap("n", "gd", "<cmd>lua require('fzf-lua').lsp_definitions()<CR>", opts("LSP definitions"))
      vim.api.nvim_set_keymap("n", "gi", "<cmd>lua require('fzf-lua').lsp_implementations()<CR>",
        opts("LSP implementations"))

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

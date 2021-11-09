local util = require'lspconfig'.util

-- Status bar components
local lsp_status = require('lsp-status')
lsp_status.register_progress()

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_set_keymap(...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  if (client.name == 'tsserver') then
    client.resolved_capabilities.document_formatting = false
  end

  -- Add status line support
  lsp_status.on_attach(client, bufnr)

  -- Highlights
  -- require 'illuminate'.on_attach(client, bufnr)

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>", opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', "<cmd>lua require('telescope.builtin').lsp_implementations()<CR>", opts)
  -- buf_set_keymap('n', '<C-K>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', "<cmd>lua require('telescope.builtin').lsp_references()<CR>", opts)
  buf_set_keymap("n", "<space>s", "<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<CR>", opts)
  buf_set_keymap("n", "<space>o", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>", opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>d", "<cmd>lua require('telescope.builtin').lsp_document_diagnostics()<CR>", opts)
  buf_set_keymap("n", "<space>D", "<cmd>lua require('telescope.builtin').lsp_workspace_diagnostics()<CR>", opts)
end

-- Configure lua language server for neovim development
local lua_settings = {
  Lua = {
    runtime = {
      -- LuaJIT in the case of Neovim
      version = 'LuaJIT',
      path = vim.split(package.path, ';'),
    },
    diagnostics = {
      -- Get the language server to recognize the `vim` global
      globals = {'vim'},
    },
    workspace = {
      -- Make the server aware of Neovim runtime files
      library = {
        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
      },
    },
  }
}

local eslint = {
    lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT} --cache",
    lintIgnoreExitCode = true,
    lintStdin = true,
    lintFormats = {"%f:%l:%c: %m"},
}

-- NOTE: isort makes formatting not instant. blackd-client is instant on its own.
local isort = {formatCommand = 'isort --quiet -', formatStdin = true}
local prettier = {
  formatCommand = 'prettierd "${INPUT}"',
  formatStdin = true,
}
local black = { formatCommand = 'blackd-client', formatStdin = true }

local efm_config = {
  init_options = {documentFormatting = true, codeAction = true},
  rootMarkers = {".git/"},
  filetypes = {
    "python", "css", "javascript", "javascriptreact", "typescript",
    "typescriptreact", "json", "html",
  },
  settings = {
      rootMarkers = {".git/"},
      languages = {
          python = {isort, black},
          javascript = {prettier, eslint},
          javascriptreact = {prettier, eslint},
          typescriptreact = {prettier, eslint},
          ["javascript.jsx"] = {prettier, eslint},
          typescript = {prettier, eslint},
          ["typescript.tsx"] = {prettier, eslint},
          css = {prettier},
          html = {prettier},
          json = {prettier, eslint}
      }
  }
}

-- config that activates keymaps and enables snippet support
local function make_lsp_config()
  -- Start with lsp's default config
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  -- Update it with cmp lsp
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

  -- Update it with lsp_status
  capabilities = vim.tbl_extend('keep', capabilities, lsp_status.capabilities)

  return {
    -- enable snippet support
    capabilities = capabilities,
    -- map buffer local keybindings when the language server attaches
    on_attach = on_attach,
  }
end

-- Sets up all supported servers
local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
  local config = make_lsp_config()

  -- language specific config
  if server.name == "lua" then
    config.settings = lua_settings
  end

  if server.name == "efm" then
    config = efm_config
  end

  if server.name == "yamlls" then
    config.filetypes = {
      'yaml',
      'yaml.docker-compose',
    }
    config.settings = {
      yaml = {
        schemas = {
          ['http://json.schemastore.org/github-workflow'] = '.github/workflows/*.{yml,yaml}',
          ['http://json.schemastore.org/github-action'] = '.github/action.{yml,yaml}',
          ['http://json.schemastore.org/prettierrc'] = '.prettierrc.{yml,yaml}',
          ['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] = {
            '*.stack.{yml,yaml}',
            'docker-compose.*.{yml,yaml}',
            'docker-compose.{yml,yaml}',
          }
        }
      }
    }
  end

  server:setup(config)
end)

 -- Autocomplete
 -- require'compe'.setup {
 --   enabled = true;
 --   autocomplete = true;
 --   debug = false;
 --   min_length = 1;
 --   preselect = 'enable';
 --   throttle_time = 80;
 --   source_timeout = 200;
 --   incomplete_delay = 400;
 --   max_abbr_width = 100;
 --   max_kind_width = 100;
 --   max_menu_width = 100;
 --   documentation = true;

 --   source = {
 --     path = true;
 --     nvim_lsp = true;
 --     orgmode = true;
 --   };
 -- }
 -- vim.o.completeopt = "menuone,noselect"
 -- vim.api.nvim_set_keymap("i", "<C-Space>", "compe#complete()", {expr = true, silent = true})
 -- vim.api.nvim_set_keymap("i", "<CR>", "compe#confirm('<CR>')", {expr = true, silent = true})
 --
 --
-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' }
  },
  formatting = {
    format = require('lspkind').cmp_format({with_text = true, maxwidth = 50})
  }
}

-- VIM Lists
vim.api.nvim_set_keymap("n", "<space>p", "<cmd>lua require('telescope.builtin').find_files()<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<space>f", "<cmd>lua require('telescope.builtin').live_grep()<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<space>m", "<cmd>lua require('telescope.builtin').oldfiles()<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<space>l", "<cmd>lua require('telescope.builtin').builtin()<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<space>b", "<cmd>lua require('telescope.builtin').buffers()<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<space>/", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<space>h", "<cmd>lua require('telescope.builtin').git_bcommits()<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<space>q", "<cmd>lua require('telescope.builtin').quickfix()<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<space>r", "<cmd>lua require('telescope.builtin').resume()<CR>", {silent = true})

-- Autoformat
vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx,*.py lua vim.lsp.buf.formatting_sync(nil, 3000)
augroup END
]], true)

-- Telescope mapping
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    preview = false,
    mappings = {
      i = {
        -- Make escape exit in insert mode as well
        ["<esc>"] = actions.close,
      },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    }
  }
}

require('telescope').load_extension('fzf')

-- Symbol highlighting
-- vim.api.nvim_command [[ hi def link LspReferenceText CursorLine ]]
-- vim.api.nvim_command [[ hi def link LspReferenceWrite CursorLine ]]
-- vim.api.nvim_command [[ hi def link LspReferenceRead CursorLine ]]

-- TreeSitter objects
require'nvim-treesitter.configs'.setup {
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
      },
    },
  },
}


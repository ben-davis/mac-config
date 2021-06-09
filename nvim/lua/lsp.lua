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

  if (client.name == 'typescript') then
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
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
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
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
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

local diagnosticls_settings = {
  filetypes = {
    "python",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "json",
    "css"
  },
  root_dir = function(fname)
      return util.root_pattern(".git")(fname)
    end,
  init_options = {
    linters = {
      eslint = {
        command = 'eslint_d',
        rootPatterns = { 'package.json' },
        debounce = 100,
        args = { '--stdin', '--stdin-filename', '%filepath', '--format', 'json' },
        sourceName = 'eslint',
        parseJson = {
          errorsRoot = '[0].messages',
          line = 'line',
          column = 'column',
          endLine = 'endLine',
          endColumn = 'endColumn',
          message = '[eslint] ${message} [${ruleId}]',
          security = 'severity'
        },
        securities = {
          [2] = 'error',
          [1] = 'warning'
        }
      },
      flake8 = {
        debounce = 100,
        sourceName = "flake8",
        command = "flake8",
        args = {
          "--format",
          "%(row)d:%(col)d:%(code)s:%(code)s: %(text)s",
          "%file",
        },
        formatPattern = {
          "^(\\d+):(\\d+):(\\w+):(\\w).+: (.*)$",
          {
              line = 1,
              column = 2,
              message = {"[", 3, "] ", 5},
              security = 4
          }
        },
        securities = {
          E = "error",
          W = "warning",
          F = "info",
          B = "hint",
        },
      },
    },
    filetypes = {
      python = 'flake8',
      javascript = 'eslint',
      javascriptreact = 'eslint',
      typescript = 'eslint',
      typescriptreact = 'eslint',
    },
    formatters = {
      black = {
        command = "black",
        args = {"--quiet", "-"}
      },
      prettier = {
        command = './node_modules/.bin/prettier',
        rootPatterns = { 'package.json' },
        args = { '--stdin-filepath', '%filename' }
      }
    },
    formatFiletypes = {
      python = {"black"},
      css = {"prettier"},
      javascript = {"prettier"},
      javascriptreact = {"prettier"},
      typescript = {"prettier"},
      typescriptreact = {"prettier"},
      json = {"prettier"},
    }
  }
}

-- config that activates keymaps and enables snippet support
local function make_config()
  local capabilities = lsp_status.capabilities

  -- Autocomplete (autoimport) & snippet support
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      'documentation',
      'detail',
      'additionalTextEdits',
    }
  }

  return {
    -- enable snippet support
    capabilities = capabilities,
    -- map buffer local keybindings when the language server attaches
    on_attach = on_attach,
  }
end

-- Sets up all supported servers
local function setup_servers()
  require'lspinstall'.setup()
  local servers = require'lspinstall'.installed_servers()
  for _, server in pairs(servers) do
    local config = make_config()

    -- language specific config
    if server == "lua" then
      config.settings = lua_settings
    end

    if server == "diagnosticls" then
      config = diagnosticls_settings
    end

    if server == "typescript" then
      config.capabilities.document_formatting = false
    end

    if server == "yaml" then
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

    require'lspconfig'[server].setup(config)
  end
end

-- Setup on startup
setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
  setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

 -- Autocomplete
 require'compe'.setup {
   enabled = true;
   autocomplete = true;
   debug = false;
   min_length = 1;
   preselect = 'enable';
   throttle_time = 80;
   source_timeout = 200;
   incomplete_delay = 400;
   max_abbr_width = 100;
   max_kind_width = 100;
   max_menu_width = 100;
   documentation = true;

   source = {
     path = true;
     nvim_lsp = true;
   };
 }
 vim.o.completeopt = "menuone,noselect"
 vim.api.nvim_set_keymap("i", "<C-Space>", "compe#complete()", {expr = true, silent = true})
 vim.api.nvim_set_keymap("i", "<CR>", "compe#confirm('<CR>')", {expr = true, silent = true})

-- VIM Lists
vim.api.nvim_set_keymap("n", "<space>p", "<cmd>lua require('telescope.builtin').find_files()<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<space>f", "<cmd>lua require('telescope.builtin').live_grep()<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<space>m", "<cmd>lua require('telescope.builtin').oldfiles()<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<space>l", "<cmd>lua require('telescope.builtin').builtin()<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<space>b", "<cmd>lua require('telescope.builtin').buffers()<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<space>/", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<space>h", "<cmd>lua require('telescope.builtin').git_bcommits()<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<space>q", "<cmd>lua require('telescope.builtin').quickfix()<CR>", {silent = true})

-- Autoformat
vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx,*.py lua vim.lsp.buf.formatting_sync()
augroup END
]], true)

-- Telescope mapping
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        -- Make escape exit in insert mode as well
        ["<esc>"] = actions.close,
      },
    },
  }
}

-- Symbol highlighting
-- vim.api.nvim_command [[ hi def link LspReferenceText CursorLine ]]
-- vim.api.nvim_command [[ hi def link LspReferenceWrite CursorLine ]]
-- vim.api.nvim_command [[ hi def link LspReferenceRead CursorLine ]]


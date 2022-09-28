require("local/lsp/null-ls")

-- require("nvim-lsp-installer").setup {}

-- Status bar components
local lsp_status = require("lsp-status")
lsp_status.register_progress()

-- Configure how diagnostics are published
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = false,
  signs = true,
  update_in_insert = false,
  underline = true,
})

-- Render diagnostics as floating lines
-- NOTE: I found this a little annoying
-- require("lsp_lines").setup()

-- Use icons for LSP gutter diagnostics
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Use custom formatting function to filter out conflicts
-- Recommended here: https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts
-- NOTE: Disabled until nvim 0.8
-- local lsp_formatting = function(bufnr)
--     vim.lsp.buf.format({
--         filter = function(clients)
--             -- filter out clients that you don't want to use
--             return vim.tbl_filter(function(client)
--                 return client.name ~= "tsserver"
--             end, clients)
--         end,
--         bufnr = bufnr,
--     })
-- end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer

-- Servers who's formatting we want to use instead of null-ls
local enabled_formatters = { "elixirls" }
local formatting_augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_set_keymap(...)
  end

  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  local opts = { noremap = true, silent = true }

  -- Add status line support
  lsp_status.on_attach(client, bufnr)

  -- Add signature help support
  require("lsp_signature").on_attach()

  -- Show diagnostics on hover
  vim.api.nvim_command("autocmd CursorHold <buffer> lua vim.diagnostic.open_float({focus = false, source = true })")

  -- Disable conflicting servers
  -- NOTE: Remove in favor of `lsp_formatting` above in 0.8 (as it will probably break)
  for _, v in pairs(enabled_formatters) do
    if client.name == v then
      client.resolved_capabilities.document_formatting = true
    else
      client.resolved_capabilities.document_formatting = false
    end
  end

  -- -- Sync format on save
  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_clear_autocmds({ group = formatting_augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = formatting_augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.formatting_sync()
      end,
    })
  end

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "gd", "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>", opts)
  buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "gi", "<cmd>lua require('telescope.builtin').lsp_implementations()<CR>", opts)
  -- buf_set_keymap('n', '<C-K>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  -- buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  -- buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  buf_set_keymap(
    "n",
    "gr",
    "<cmd>lua require('telescope.builtin').lsp_references({ includeDeclaration = false })<CR>",
    opts
  )
  buf_set_keymap(
    "n",
    "<space>ci",
    "<cmd>lua require('telescope.builtin').lsp_incoming_calls()<CR>",
    opts
  )
  buf_set_keymap(
    "n",
    "<space>co",
    "<cmd>lua require('telescope.builtin').lsp_outgoing_calls()<CR>",
    opts
  )
  buf_set_keymap("n", "<space>s", "<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<CR>", opts)
  buf_set_keymap("n", "<space>o", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>", opts)
  buf_set_keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>d", "<cmd>lua require('telescope.builtin').diagnostics( {bufnr = 0} )<CR>", opts)
  buf_set_keymap("n", "<space>D", "<cmd>lua require('telescope.builtin').diagnostics()<CR>", opts)
end

-- Configure lua language server for neovim development
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local lua_settings = {
  Lua = {
    runtime = {
      -- LuaJIT in the case of Neovim
      version = "LuaJIT",
      path = runtime_path,
    },
    diagnostics = {
      -- Get the language server to recognize the `vim` global
      globals = { "vim" },
    },
    workspace = {
      -- Make the server aware of Neovim runtime files
      library = vim.api.nvim_get_runtime_file("", true),
    },
  },
}

local function on_init(client, result)
  if client.name == "pyright" then
    local project_name = client.config.root_dir:match("^.+/(.+)$")

    -- This is rupalabs
    if project_name == "server" then
      client.config.settings.python.pythonPath = "/Users/ben/.local/share/virtualenvs/server-iwTf5wu_/bin/python"
    elseif project_name == "fastapi-resources" then
      client.config.settings.python.pythonPath = "/Users/ben/Library/Caches/pypoetry/virtualenvs/fastapi-resources-lgcGwL0s-py3.10/bin/python"
    else
      client.config.settings.python.pythonPath = "/usr/local/opt/python@3.10/libexec/bin/python"
    end

    client.notify("workspace/didChangeConfiguration")
  end

  return true
end

-- config that activates keymaps and enables snippet support
local function make_lsp_config()
  -- Start with lsp's default config
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  -- Update it with cmp lsp
  capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

  -- Update it with lsp_status
  capabilities = vim.tbl_extend("keep", capabilities, lsp_status.capabilities)

  return {
    -- enable snippet support
    capabilities = capabilities,
    -- map buffer local keybindings when the language server attaches
    on_attach = on_attach,
    on_init = on_init,
  }
end

-- Sets up all supported servers
local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
  local config = make_lsp_config()

  -- language specific config
  if server.name == "sumneko_lua" then
    config.settings = lua_settings
  end

  if server.name == "json" then
    config.settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
      },
    }
  end

  if server.name == "yamlls" then
    config.filetypes = {
      "yaml",
      "yaml.docker-compose",
    }
    config.settings = {
      yaml = {
        schemas = require("schemastore").json.schemas(),
      },
    }
  end

  if server.name == "clangd" then
    config.capabilities.offsetEncoding = { "utf-16" }
  end

  server:setup(config)
end)

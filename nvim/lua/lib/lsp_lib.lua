local M = {}

M.on_attach = function(client, bufnr)
  local navic = require("nvim-navic")
  local lsp_status = require("lsp-status")

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
  lsp_status.on_attach(client)

  -- Add code nav status bar
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end

  -- Add signature help support
  require("lsp_signature").on_attach()

  -- Show diagnostics on hover
  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
      vim.diagnostic.open_float({ focus = false, source = true })
    end
  })

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  buf_set_keymap("n", "<space>R", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  buf_set_keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
end

M.on_init = function(client, result)
  if client.name == "pyright" then
    local poetry_env =
        vim.trim(vim.fn.system('cd "' .. client.config.root_dir .. '"; poetry env info -p 2>/dev/null'))

    local venv_python_path = client.config.root_dir .. "/.venv/bin/python"

    if vim.fn.filereadable(venv_python_path) == 1 then
      client.config.settings.python.pythonPath = venv_python_path
    elseif poetry_env then
      client.config.settings.python.pythonPath = poetry_env .. "/bin/python"
    else
      client.config.settings.python.pythonPath = "/usr/local/opt/python@3.10/libexec/bin/python"
    end

    client.notify("workspace/didChangeConfiguration")
  elseif client.name == "ruff" then
    client.server_capabilities.hoverProvider = false
  end

  return true
end

M.make_default_config = function()
  local lsp_status = require("lsp-status")

  -- config that activates keymaps and enables snippet support
  -- Start with lsp's default config
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  -- Update it with cmp lsp
  capabilities = vim.tbl_extend("keep", capabilities, require("cmp_nvim_lsp").default_capabilities())

  -- Update it with lsp_status
  capabilities = vim.tbl_extend("keep", capabilities, lsp_status.capabilities)

  return {
    -- enable snippet support
    capabilities = capabilities,
    -- map buffer local keybindings when the language server attaches
    on_attach = M.on_attach,
    on_init = M.on_init,
  }
end

return M

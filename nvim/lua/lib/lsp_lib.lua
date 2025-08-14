local M = {}

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
  -- config that activates keymaps and enables snippet support
  -- Start with lsp's default config
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  -- Update it with cmp lsp
  capabilities = vim.tbl_extend("keep", capabilities, require("cmp_nvim_lsp").default_capabilities())

  return {
    -- enable snippet support
    capabilities = capabilities,
    on_init = M.on_init,
  }
end

return M

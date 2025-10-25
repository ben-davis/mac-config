local godot = require("lib.godot")

local function start_neovim_server()
  local godot_project_dir = godot.get_godot_project_dir()
  if not godot_project_dir then
    return
  end

  local pipe_path = godot_project_dir .. "neovim.pipe"

  -- check if server is already running in godot project path
  local is_server_running = vim.uv.fs_stat(pipe_path)
  -- start server, if not already running
  if not is_server_running then
    vim.notify("Starting neovim pipe on" .. pipe_path)
    vim.fn.serverstart(pipe_path)
  end
end

return {
  {
    "virtual-godot-plugin",
    virtual = true,
    dependencies = {
      "stevearc/overseer.nvim",
    },
    config = function()
      start_neovim_server()
    end,
  },
}

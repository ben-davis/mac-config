local M = {}

function M.get_godot_project_dir()
  local godot_project_dir = vim.fn.getcwd() .. "/src/"

  if vim.uv.fs_stat(godot_project_dir) then
    return godot_project_dir
  end

  return nil
end

return M

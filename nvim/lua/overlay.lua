local M = {}

M.add_runtime_dir = function(path)
  if type(path) ~= "string" or path == "" then
    return
  end
  local expanded = vim.fn.expand(path)
  if vim.fn.isdirectory(expanded) == 1 then
    -- Prepend so overlays take precedence
    vim.o.runtimepath = expanded .. "," .. vim.o.runtimepath
  end
end

M.add_overlays_from_dir = function(dir)
  local d = vim.fn.expand(dir)
  if vim.fn.isdirectory(d) ~= 1 then
    return {}
  end

  local names = {}

  -- Iterate directory entries
  for _, name in ipairs(vim.fn.readdir(d)) do
    local p = d .. "/" .. name
    if vim.fn.isdirectory(p) == 1 then
      M.add_runtime_dir(p)
    end

    table.insert(names, name)
  end

  return names
end

return M

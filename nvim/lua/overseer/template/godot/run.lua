local godot = require("lib.godot")

return {
  -- Required fields
  name = "godot.run_main",
  builder = function(_)
    return {
      cmd = { "godot" },
      args = {},
      name = "godot.run_main",
      cwd = godot.get_godot_project_dir(),
      -- the list of components or component aliases to add to the task
      components = { "default", "unique" },
    }
  end,
  -- Optional fields
  desc = "Runs the Main scene",
  params = {
    -- See :help overseer-params
  },
  -- Determines sort order when choosing tasks. Lower comes first.
  priority = 50,
  -- Add requirements for this template. If they are not met, the template will not be visible.
  -- All fields are optional.
  condition = {
    -- Arbitrary logic for determining if task is available
    callback = function()
      return godot.get_godot_project_dir() ~= nil
    end,
  },
}

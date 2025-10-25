local godot = require("lib.godot")

-- Extract bundle ID from Godot export preset
local function get_bundle_id_from_godot(project_path)
  local export_presets_path = project_path .. "export_presets.cfg"
  local preset_name = "iOS"

  local file = io.open(export_presets_path, "r")
  if not file then
    return nil
  end

  local content = file:read("*all")
  file:close()

  -- Find the preset section
  local in_preset = false
  local found_preset = false

  for line in content:gmatch("[^\r\n]+") do
    -- Check if we're entering the right preset
    if line:match("%[preset%.%d+%]") then
      in_preset = false
      found_preset = false
    end

    -- Check if this is our target preset
    if in_preset and line:match("^name=") then
      local name = line:match('^name="([^"]+)"')
      if name == preset_name then
        found_preset = true
      else
        in_preset = false
      end
    end

    if line:match("%[preset%.%d+%]") then
      in_preset = true
    end

    -- Extract bundle_id from the right preset
    if found_preset and line:match("^application/bundle_identifier=") then
      local bundle_id = line:match('^application/bundle_identifier="([^"]+)"')
      return bundle_id
    end
  end

  return nil
end

return {
  name = "godot.run_on_ios",
  builder = function(params)
    local godot_bin = params.godot_binary
    local godot_project_dir = godot.get_godot_project_dir()
    local export_path = params.export_path
    local export_type = params.export_type
    local bundle_id = params.bundle_id
    if not bundle_id then
      bundle_id = get_bundle_id_from_godot(godot_project_dir)
    end

    return {
      name = "Godot iOS Build and Deploy",
      strategy = {
        "orchestrator",
        tasks = {
          -- Task 1: Build the IPA with Godot
          {
            name = "Build IPA",
            cmd = {
              godot_bin,
              "--headless",
              "--path",
              godot_project_dir,
              "--export-" .. export_type,
              "iOS",
              export_path,
            },
            components = {
              "default",
              "unique",
            },
          },
          {
            name = "Deploy to iOS Device",
            cmd = { "xcrun", "devicectl", "device", "install", "app", "--device", "{device}", export_path },
            components = {
              -- This replaces the {device} in the command above
              { "godot.ios_device" },
              "default",
              "unique",
            },
          },
          {
            name = "Launch App on Device",
            cmd = { "xcrun", "devicectl", "device", "process", "launch", "--device", "{device}", bundle_id },
            components = {
              { "godot.ios_device" },
              "default",
              "unique",
            },
          },
        },
      },
    }
  end,
  params = function()
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")

    return {
      godot_binary = {
        desc = "Path to Godot binary",
        type = "string",
        default = "godot",
        optional = true,
      },
      export_type = {
        desc = "Godot export type",
        type = "enum",
        default = "debug",
        optional = true,
        choices = {
          "debug",
          "release",
        },
      },
      export_path = {
        desc = "Output path for .ipa file",
        type = "string",
        default = vim.fn.getcwd() .. "/ios/" .. project_name .. ".ipa",
        optional = true,
      },
      bundle_id = {
        desc = "iOS app bundle identifier (auto-detected from export_presets.cfg if not provided)",
        type = "string",
        optional = true,
      },
    }
  end,
  desc = "Build Godot project for iOS and deploy to device",
  priority = 50,
  condition = {
    callback = function()
      local godot_project_dir = godot.get_godot_project_dir()
      local has_godot = vim.fn.executable("godot") == 1
      local has_xcrun = vim.fn.executable("xcrun") == 1
      return godot_project_dir and has_godot and has_xcrun
    end,
  },
}

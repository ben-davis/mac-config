-- Parse JSON output from devicectl
local function parse_devices(json_path)
  local file = io.open(json_path, "r")
  if not file then
    return nil, "Failed to open JSON file"
  end

  local content = file:read("*all")
  file:close()

  local ok, decoded = pcall(vim.json.decode, content)
  if not ok then
    return nil, "Failed to parse JSON: " .. tostring(decoded)
  end

  local devices = {}

  -- Parse the device list from JSON structure
  if decoded.result and decoded.result.devices then
    for _, device in ipairs(decoded.result.devices) do
      if device.deviceProperties then
        local props = device.deviceProperties
        table.insert(devices, {
          name = props.name or "Unknown Device",
          identifier = device.identifier,
          model = props.marketingName or props.deviceType or "Unknown Model",
          state = device.connectionProperties and device.connectionProperties.tunnelState or "unknown",
        })
      end
    end
  end

  return devices, nil
end

-- Prompt user to select a device
local function select_device(devices, callback)
  local options = {}
  for i, device in ipairs(devices) do
    table.insert(options, string.format("%d. %s - %s (%s)", i, device.name, device.model, device.state))
  end

  vim.ui.select(options, {
    prompt = "Select iOS device:",
  }, function(choice, idx)
    if idx then
      callback(devices[idx].identifier)
    else
      callback(nil)
    end
  end)
end

-- Main function to get device ID
local function get_ios_device_id(callback)
  -- Create temp file for JSON output
  local json_path = vim.fn.tempname() .. ".json"

  local cmd = {
    "xcrun",
    "devicectl",
    "list",
    "devices",
    "--filter",
    "hardwareProperties.platform CONTAINS 'iOS'",
    "--json-output",
    json_path,
  }

  vim.fn.jobstart(cmd, {
    on_exit = function(_, exit_code)
      if exit_code ~= 0 then
        vim.notify("Failed to list devices (exit code: " .. exit_code .. ")", vim.log.levels.ERROR)
        -- Clean up temp file
        vim.fn.delete(json_path)
        callback(nil)
        return
      end

      -- Parse the JSON output
      local devices, err = parse_devices(json_path)

      -- Clean up temp file
      vim.fn.delete(json_path)

      if err then
        vim.notify("Error parsing device list: " .. err, vim.log.levels.ERROR)
        callback(nil)
        return
      end

      if not devices or #devices == 0 then
        vim.notify("No iOS devices found", vim.log.levels.WARN)
        callback(nil)
      elseif #devices == 1 then
        vim.notify("Using device: " .. devices[1].name, vim.log.levels.INFO)
        callback(devices[1].identifier)
      else
        select_device(devices, callback)
      end
    end,
    on_stderr = function(_, data)
      if data and #data > 0 and data[1] ~= "" then
        vim.notify("Error: " .. table.concat(data, "\n"), vim.log.levels.ERROR)
      end
    end,
  })
end

-- Overseer component for iOS device selection
return {
  desc = "Select iOS device before running task",
  params = {
    device_id = {
      desc = "iOS device identifier (will prompt if not provided)",
      type = "string",
      optional = true,
    },
  },
  constructor = function(params)
    return {
      device_id = params.device_id,
      on_pre_start = function(self, task)
        if self.device_id then
          -- Device already selected, inject it into the command
          for i, arg in ipairs(task.cmd) do
            if arg == "{device}" then
              task.cmd[i] = self.device_id
            end
          end
          return true
        end

        -- Need to select device
        get_ios_device_id(function(device_id)
          if device_id then
            self.device_id = device_id
            -- Inject device_id into command
            for i, arg in ipairs(task.cmd) do
              if arg == "{device}" then
                task.cmd[i] = device_id
              end
            end
            -- Start the task now that we have the device
            task:start()
          else
            task:finalize(1, os.time())
          end
        end)

        -- Return false to prevent immediate start
        return false
      end,
    }
  end,
}

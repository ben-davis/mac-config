require("local/options")
require("local/digraphs")
require("local/keymap")
require("local/react-native")
require("local/diagnostics")

-- Any dirs in ~/.config/nvim.d must be a config dir that could be
-- mounted in `~/.config/nvim`
local overlay = require("overlay")
local overlay_names = overlay.add_overlays_from_dir("~/.config/nvim.d")

local overlay_plugin_names = {}
for _, overlay_name in ipairs(overlay_names) do
	table.insert(overlay_plugin_names, overlay_name .. "_plugins")
end

local lazy = require("config.lazy")
lazy.setup({})

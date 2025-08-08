vim.api.nvim_command("source ~/.config/nvim/plugins.vim")

require("local/digraphs")
require("local/keymap")
require("local/options")
require("local/react-native")

require("config.lazy")


if vim.fn.isdirectory(vim.fn.expand("~/.config/nvim/lua/overrides")) > 0 then
  require("overrides")
end

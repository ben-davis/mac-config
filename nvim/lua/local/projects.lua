-- NOTE: Handled this via on_init on the LSP server config.
-- function _G.onChangeDirectory()
--     local cwd = vim.fn.getcwd()
--     local project_name = cwd:match("^.+/(.+)$")
--     vim.notify(project_name)
-- end
-- vim.api.nvim_exec(
--     [[
-- augroup LoadProjectAutogroup
-- autocmd!
-- autocmd DirChanged global lua onChangeDirectory()
-- augroup END
-- ]],
--     true
-- )
--
require("project_nvim").setup({
  scope_chdir = "tab"
})

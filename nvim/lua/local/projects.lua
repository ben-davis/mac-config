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
  manual_mode = true,
  scope_chdir = "tab",
  -- Disable lsp detection as it doesn't work for non-lsp sources like personal notes. Plus
  -- I'm using manual_mode which disables autochdir based when LSP attaches.
  detection_methods = { "pattern" },
  -- Added .zk to handle my personal notes
  patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", ".zk" },
})

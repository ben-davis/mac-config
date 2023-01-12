vim.keymap.set("n", "<leader>k", ":DashWord<CR>", { noremap = true })
vim.keymap.set("n", "<space>k", ":Dash<CR>", { noremap = true })

require("dash").setup({
  file_type_keywords = {
    python = { "python3", "Django", "sqlalchemy", "pytest" },
    javascript = { "javascript", "nodejs" },
    typescript = { "typescript", "javascript", "nodejs" },
    typescriptreact = { "typescript", "javascript", "react" },
    javascriptreact = { "javascript", "react" },
    swift = { "swift", "apple" },
    objc = { "objc", "apple" },
    objcpp = { "objcpp", "apple" },
  },
})

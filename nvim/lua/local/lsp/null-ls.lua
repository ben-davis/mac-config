local augroup = vim.api.nvim_create_augroup("LspFormatting", {})


require("null-ls").setup({
  debug = true,
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 10000 })
        end,
      })
    end
  end,
  sources = {
    -- require("null-ls").builtins.completion.spell.with({
    -- 	filetypes = { "markdown" },
    -- }),
    require("null-ls").builtins.code_actions.eslint_d,
    -- require("null-ls").builtins.code_actions.proselint,

    require("null-ls").builtins.diagnostics.eslint_d,
    require("null-ls").builtins.diagnostics.actionlint,
    -- require("null-ls").builtins.diagnostics.proselint,

    require("null-ls").builtins.formatting.stylua,
    require("null-ls").builtins.formatting.isort,
    require("null-ls").builtins.formatting.black,
    require("null-ls").builtins.formatting.clang_format,
    require("null-ls").builtins.formatting.prettierd,
    require("null-ls").builtins.formatting.rustfmt,

    require("null-ls").builtins.hover.dictionary,
  },
})

require("null-ls").setup({
	debug = true,
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
		require("null-ls").builtins.formatting.prettier,
		require("null-ls").builtins.formatting.rustfmt,
		require("null-ls").builtins.formatting.swiftformat,

		require("null-ls").builtins.hover.dictionary,
	},
})

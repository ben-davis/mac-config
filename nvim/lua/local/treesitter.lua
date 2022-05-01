require("nvim-treesitter.configs").setup({
	ensure_installed = "all",
	ignore_install = { "markdown" },
	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
		-- Treesitter Python indentation gets a lot wrong. I'm using Vimjas/vim-python-pep8-indent to correct.
		disable = { "python" },
	},
})

-- TreeSitter objects
require("nvim-treesitter.configs").setup({
	textobjects = {
		select = {
			enable = true,
			-- Automatically jump forward to textobj, similar to targets.vim
			lookahead = true,
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
				["ab"] = "@block.outer",
				["ib"] = "@block.inner",
			},
		},
	},
})

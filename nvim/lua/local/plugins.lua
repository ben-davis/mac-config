-- Git signs
require("gitsigns").setup()

-- Setup autopairs
require("nvim-autopairs").setup({
	enable_check_bracket_line = false,
})

-- Zen mode
require("zen-mode").setup()
vim.keymap.set("n", "<leader>z", ":ZenMode<CR>", { silent = true, noremap = true })

-- Email
vim.g["himalaya_mailbox_picker"] = "telescope"
vim.g["himalaya_telescope_preview_enabled"] = 1

vim.keymap.set("n", "<leader>m", ":Himalaya<CR>", { silent = true, noremap = true })

-- Floaterm
local function toggle_floaterm()
	local cwd = vim.fn.getcwd(0, 0)
	local project = vim.fn.fnamemodify(cwd, ":t")

	local bufnr = vim.fn["floaterm#terminal#get_bufnr"](project)

	if bufnr > -1 then
		vim.api.nvim_command(bufnr .. "FloatermToggle")
	else
		vim.api.nvim_command(
			"FloatermNew --height=0.8 --width=0.9 --wintype=float --name="
				.. project
				.. " --title="
				.. project
				.. " --position=center"
		)
	end
end

vim.keymap.set({ "n", "t" }, "<leader>a", toggle_floaterm, { silent = true, noremap = true })
vim.keymap.set({ "n", "t" }, "<leader>f", ":FloatermToggle<CR>", { silent = true, noremap = true })

-- Git blame popup
-- The plugin doesn't need setup but I'm adding a comment so I have a reminder. The plugin sets <leader>gm as the map.

-- Whichkey
require("which-key").setup()

-- Floating goto previews
require("goto-preview").setup({
	default_mappings = true,
})

-- Leap
require("leap").add_default_mappings()

-- Copy to cliupboardA
require("osc52").setup({
	max_length = 0, -- Maximum length of selection (0 for no limit)
	silent = false, -- Disable message on successful copy
	trim = false, -- Trim surrounding whitespaces before copy
	tmux_passthrough = true, -- Use tmux passthrough (requires tmux: set -g allow-passthrough on)
})

-- LSP outline
require("outline").setup({
	outline_window = {
		position = "right",
		auto_jump = false,
		width = 14,
	},
	outline_items = {
		show_symbol_lineno = true,
	},
})
vim.keymap.set({ "n" }, "<leader>o", ":Outline<CR>", { silent = true, noremap = true })
vim.keymap.set({ "n" }, "<leader>O", ":OutlineFocus<CR>", { silent = true, noremap = true })

-- Diffview
vim.keymap.set({ "n" }, "<leader>h", ":DiffviewFileHistory<CR>", { silent = true, noremap = true })
vim.keymap.set({ "n" }, "<leader>H", ":DiffviewFileHistory %<CR>", { silent = true, noremap = true })
vim.keymap.set({ "n" }, "<leader>G", ":DiffviewOpen<CR>", { silent = true, noremap = true })

-- GPT
local config = {
	api_host_cmd = "echo http://localhost:11434",
	api_key_cmd = "echo ollama",
	openai_params = {
		-- model = "codellama:13b",
		-- model = "deepseek-coder:6.7b",
		-- model = "gemma:7b",
		model = "llama3",
	},
	openai_edit_params = {
		-- model = "codellama:13b",
		-- model = "deepseek-coder:6.7b",
		model = "llama3",
	},
}

require("chatgpt").setup(config)
require("ogpt").setup({
	default_provider = "ollama",
	-- single_window = false, -- set this to true if you want only one OGPT window to appear at a time
	providers = {
		ollama = {
			api_host = os.getenv("OLLAMA_API_HOST") or "http://localhost:11434",
			api_key = os.getenv("OLLAMA_API_KEY") or "",
			model = "llama3",
			api_params = {
				model = "llama3",
			},
			api_chat_params = {
				model = "llama3",
			},
		},
	},
	edit = {
		edgy = nil, -- use global default, override if defined
		diff = false,
		keymaps = {
			close = "<C-c>",
			accept = "<M-CR>",
			toggle_diff = "<C-d>",
			toggle_parameters = "<C-p>",
			cycle_windows = "<Tab>",
			use_output_as_input = "<C-u>",
		},
	},
	output_window = {
		buf_options = {
			filetype = "markdown",
			syntax = "markdown",
		},
	},
})

-- LLMs
-- Can't get this to work
-- require("llm").setup({
-- 	backend = "ollama",
-- 	-- model = "codellama:13b",
-- 	model = "deepseek-coder:6.7b",
-- 	accept_keymap = "<Tab>",
-- 	dismiss_keymap = "<S-Tab>",
-- 	url = "http://localhost:11434/api/generate",
-- 	tokens_to_clear = { "<|endoftext|>" },
-- 	fim = {
-- 		enabled = true,
-- 		prefix = "<fim_prefix>",
-- 		middle = "<fim_middle>",
-- 		suffix = "<fim_suffix>",
-- 	},
-- 	context_window = 8192,
-- 	request_body = {
-- 		options = {
-- 			temperature = 0.2,
-- 			top_p = 0.95,
-- 		},
-- 	},
-- 	enable_suggestions_on_startup = false,
-- 	lsp = {
-- 		bin_path = vim.api.nvim_call_function("stdpath", { "data" }) .. "/mason/bin/llm-ls",
-- 	},
-- })

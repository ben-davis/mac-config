local navic = require("nvim-navic")

-- Status bar components
local lsp_status = require("lsp-status")
lsp_status.register_progress()

-- Configure how diagnostics are published
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	signs = true,
	update_in_insert = false,
	underline = true,
})

-- Render diagnostics as floating lines
-- NOTE: I found this a little annoying
-- require("lsp_lines").setup()

-- Use icons for LSP gutter diagnostics
local signs = {
	[vim.diagnostic.severity.ERROR] = " ",
	[vim.diagnostic.severity.WARN] = " ",
	[vim.diagnostic.severity.HINT] = " ",
	[vim.diagnostic.severity.INFO] = " ",
}

for severity, icon in pairs(signs) do
	local name = vim.diagnostic.severity[severity]:lower():gsub("^%l", string.upper)
	name = "DiagnosticSign" .. name
	vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
end

local formatting_augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_set_keymap(...)
	end

	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	--Enable completion triggered by <c-x><c-o>
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	local opts = { noremap = true, silent = true }

	-- Add status line support
	lsp_status.on_attach(client)

	-- Add code nav status bar
	if client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
	end

	-- Add signature help support
	require("lsp_signature").on_attach()

	-- Show diagnostics on hover
	vim.api.nvim_command("autocmd CursorHold <buffer> lua vim.diagnostic.open_float({focus = false, source = true })")


	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>", opts)
	buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua require('telescope.builtin').lsp_implementations()<CR>", opts)
	-- buf_set_keymap('n', '<C-K>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	-- buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	-- buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	-- buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "<space>R", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	buf_set_keymap(
		"n",
		"gr",
		"<cmd>lua require('telescope.builtin').lsp_references({ includeDeclaration = false })<CR>",
		opts
	)
	buf_set_keymap("n", "<space>ci", "<cmd>lua require('telescope.builtin').lsp_incoming_calls()<CR>", opts)
	buf_set_keymap("n", "<space>co", "<cmd>lua require('telescope.builtin').lsp_outgoing_calls()<CR>", opts)
	buf_set_keymap("n", "<space>s", "<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<CR>", opts)
	buf_set_keymap("n", "<space>o", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>", opts)
	buf_set_keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
	-- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
	buf_set_keymap("n", "<space>d", "<cmd>lua require('telescope.builtin').diagnostics( {bufnr = 0} )<CR>", opts)
	buf_set_keymap("n", "<space>D", "<cmd>lua require('telescope.builtin').diagnostics()<CR>", opts)
end

require("mason").setup()
require("mason-lspconfig").setup({
	automatic_installation = true,
})

local function on_init(client, result)
	if client.name == "pyright" then
		local poetry_env =
			vim.trim(vim.fn.system('cd "' .. client.config.root_dir .. '"; poetry env info -p 2>/dev/null'))

		local venv_python_path = client.config.root_dir .. "/.venv/bin/python"

		if vim.fn.filereadable(venv_python_path) == 1 then
			client.config.settings.python.pythonPath = venv_python_path
		elseif poetry_env then
			client.config.settings.python.pythonPath = poetry_env .. "/bin/python"
		else
			client.config.settings.python.pythonPath = "/usr/local/opt/python@3.10/libexec/bin/python"
		end

		client.notify("workspace/didChangeConfiguration")
	elseif client.name == "ruff" then
		client.server_capabilities.hoverProvider = false
	end

	return true
end

-- config that activates keymaps and enables snippet support
local function make_default_config()
	-- Start with lsp's default config
	local capabilities = vim.lsp.protocol.make_client_capabilities()

	-- Update it with cmp lsp
	capabilities = vim.tbl_extend("keep", capabilities, require("cmp_nvim_lsp").default_capabilities())

	-- Update it with lsp_status
	capabilities = vim.tbl_extend("keep", capabilities, lsp_status.capabilities)

	return {
		-- enable snippet support
		capabilities = capabilities,
		-- map buffer local keybindings when the language server attaches
		on_attach = on_attach,
		on_init = on_init,
	}
end

local default_config = make_default_config()

-- Configure lua language server for neovim development
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local lua_settings = {
	Lua = {
		runtime = {
			-- LuaJIT in the case of Neovim
			version = "LuaJIT",
			path = runtime_path,
		},
		diagnostics = {
			-- Get the language server to recognize the `vim` global
			globals = { "vim" },
		},
		workspace = {
			-- Make the server aware of Neovim runtime files
			library = vim.api.nvim_get_runtime_file("", true),
		},
	},
}

local servers = {
	pyright = function(config)
		config.settings = {
			python = {
				analysis = {
					autoSearchPaths = true,
					diagnosticMode = "workspace",
					useLibraryCodeForTypes = true,
					autoImportCompletions = true,
				},
			},
		}
		return config
	end,
	ts_ls = function(config)
		return config
	end,
	ruff = function(config)
		return config
	end,
	ruby_lsp = function(config)
		return config
	end,
	sorbet = function(config)
		return config
	end,
	-- vtsls = function(config)
	-- 	return config
	-- end,
	html = function(config)
		return config
	end,

	jsonls = function(config)
		config.settings = {
			json = {
				schemas = require("schemastore").json.schemas(),
			},
		}
		return config
	end,
	lua_ls = function(config)
		config.settings = lua_settings
		return config
	end,
	yamlls = function(config)
		config.filetypes = {
			"yaml",
			"yaml.docker-compose",
		}
		config.settings = {
			yaml = {
				schemas = require("schemastore").json.schemas(),
			},
		}
		return config
	end,
	-- clangd = function(config)
	--   config.capabilities.offsetEncoding = { "utf-16" }
	--   return config
	-- end,
	ccls = function(config)
		return config
	end,
	-- tailwindcss = function(config)
	-- 	return config
	-- end,
	sourcekit = function(config)
		config.cmd =
			{ "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp" }
		return config
	end,
	hls = function(config)
		return config
	end,
}

for name, update_config in pairs(servers) do
	local config = {
		on_attach = default_config.on_attach,
		on_init = default_config.on_init,
		capabilities = default_config.capabilities,
	}

	if update_config then
		config = update_config(config)
	end

	require("lspconfig")[name].setup(config)
end

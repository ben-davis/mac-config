local util = require("lspconfig").util

-- Status bar components
local lsp_status = require("lsp-status")
lsp_status.register_progress()

-- Configure how diagnostics are published
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	virtual_text = false,
	signs = true,
	update_in_insert = false,
	underline = true,
})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
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
	lsp_status.on_attach(client, bufnr)

	-- Add signature help support
	require("lsp_signature").on_attach()

	-- Show diagnostics on hover
	vim.api.nvim_command("autocmd CursorHold <buffer> lua vim.diagnostic.open_float({focus = false, source = true })")

	-- So that the only client with format capabilities is efm
	if client.name ~= "efm" then
		client.resolved_capabilities.document_formatting = false
	end

	if client.resolved_capabilities.document_formatting then
		-- Autoformat
		vim.api.nvim_exec(
			[[
              augroup Format
                au! * <buffer>
                au BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 5000)
              augroup END
            ]],
			true
		)
	end

	-- Highlights
	-- require 'illuminate'.on_attach(client, bufnr)

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>", opts)
	buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua require('telescope.builtin').lsp_implementations()<CR>", opts)
	-- buf_set_keymap('n', '<C-K>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	buf_set_keymap(
		"n",
		"gr",
		"<cmd>lua require('telescope.builtin').lsp_references({ includeDeclaration = false })<CR>",
		opts
	)
	buf_set_keymap("n", "<space>s", "<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<CR>", opts)
	buf_set_keymap("n", "<space>o", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>", opts)
	buf_set_keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
	-- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
	buf_set_keymap("n", "<space>d", "<cmd>lua require('telescope.builtin').diagnostics( {bufnr = 0} )<CR>", opts)
	buf_set_keymap("n", "<space>D", "<cmd>lua require('telescope.builtin').diagnostics()<CR>", opts)
end

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

local eslint = {
	lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT} --cache",
	lintIgnoreExitCode = true,
	lintStdin = true,
	lintFormats = { "%f:%l:%c: %m" },
	-- Doesn't work
	-- formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
	-- formatStdin = true,
	commands = {
		{
			title = "eslint fix",
			command = "eslint",
			arguments = {
				"--fix",
				"${INPUT}",
			},
		},
	},
}

local luaFormat = {
	formatCommand = "stylua -",
	formatStdin = true,
	lintSeverity = 2,
}

-- NOTE: isort makes formatting not instant. blackd-client is instant on its own.
local isort = { formatCommand = "isort --quiet -", formatStdin = true }
local prettier = {
	formatCommand = 'prettierd "${INPUT}"',
	formatStdin = true,
	-- formatCommand = "./node_modules/.bin/prettier --stdin-filepath ${INPUT}",
	-- formatStdin = true
}
local black = { formatCommand = "blackd-client", formatStdin = true }
local clangFormat = { formatCommand = "clang-format", formatStdin = true }

local function make_efm_config(config)
	config.init_options = { documentFormatting = true, codeAction = true }
	config.rootMarkers = { ".git/" }
	config.filetypes = {
		"python",
		"css",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"json",
		"html",
		"lua",
		"c",
		"markdown",
	}
	config.settings = {
		rootMarkers = { ".git/" },
		languages = {
			python = { isort, black },
			javascript = { prettier, eslint },
			javascriptreact = { prettier, eslint },
			typescriptreact = { prettier, eslint },
			["javascript.jsx"] = { prettier, eslint },
			typescript = { prettier, eslint },
			["typescript.tsx"] = { prettier, eslint },
			css = { prettier },
			html = { prettier },
			json = { prettier, eslint },
			lua = { luaFormat },
			c = { clangFormat },
			markdown = { prettier },
		},
	}

	return config
end

local function on_init(client, result)
	if client.name == "pyright" then
		local project_name = client.config.root_dir:match("^.+/(.+)$")

		-- This is rupalabs
		if project_name == "server" then
			client.config.settings.python.pythonPath = "/Users/ben/dev/.venvs/server-iwTf5wu_/bin/python"
		elseif project_name == "fastapi-rest-framework" then
			client.config.settings.python.pythonPath =
				"/Users/ben/Library/Caches/pypoetry/virtualenvs/fastapi-rest-framework-rZAynlgp-py3.10/bin/python"
		else
			client.config.settings.python.pythonPath = "/usr/local/opt/python@3.10/libexec/bin/python"
		end

		client.notify("workspace/didChangeConfiguration")
	end

	return true
end

-- config that activates keymaps and enables snippet support
local function make_lsp_config()
	-- Start with lsp's default config
	local capabilities = vim.lsp.protocol.make_client_capabilities()

	-- Update it with cmp lsp
	capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

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

-- Sets up all supported servers
local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
	local config = make_lsp_config()

	-- language specific config
	if server.name == "sumneko_lua" then
		config.settings = lua_settings
	end

	if server.name == "efm" then
		config = make_efm_config(config)
	end

	if server.name == "json" then
		config.settings = {
			json = {
				schemas = require("schemastore").json.schemas(),
			},
		}
	end

	if server.name == "yamlls" then
		config.filetypes = {
			"yaml",
			"yaml.docker-compose",
		}
		config.settings = {
			yaml = {
				schemas = require("schemastore").json.schemas(),
			},
		}

		-- config.settings = {
		--   yaml = {
		--     schemas = {
		--       ['http://json.schemastore.org/github-workflow'] = '.github/workflows/*.{yml,yaml}',
		--       ['http://json.schemastore.org/github-action'] = '.github/action.{yml,yaml}',
		--       ['http://json.schemastore.org/prettierrc'] = '.prettierrc.{yml,yaml}',
		--       ['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] = {
		--         '*.stack.{yml,yaml}',
		--         'docker-compose.*.{yml,yaml}',
		--         'docker-compose.{yml,yaml}',
		--       }
		--     }
		--   }
		-- }
	end

	if server.name == "clangd" then
		config.capabilities.offsetEncoding = { "utf-16" }
	end

	server:setup(config)
end)

-- NOTE: Disabling as it broke startup for some reason
-- -- Add custom installer for unifiedls
-- local configs = require "lspconfig/configs"
-- local lspconfig = require "lspconfig"
-- local server = require "nvim-lsp-installer.server"
-- local npm = require "nvim-lsp-installer.installers.npm"
-- local servers = require "nvim-lsp-installer.servers"
-- local path = require "nvim-lsp-installer.path"

-- local server_name = "unified_language_server"

-- configs[server_name] = {
--     default_config = {
--         filetypes = {"markdown"},
--         root_dir = lspconfig.util.root_pattern ".git"
--     }
-- }

-- local root_dir = server.get_server_root_path(server_name)

-- local installer = npm.packages {"unified-language-server"}
-- local unified_language_server =
--     server.Server:new {
--     name = server_name,
--     root_dir = root_dir,
--     installer = installer,
--     default_options = {
--         cmd = {
--             path.concat {root_dir, "node_modules", ".bin", "unified-language-server"},
--             "--parser=remark-parse",
--             "--stdio"
--         }
--     }
-- }

-- -- 3. (optional, recommended) Register your server with nvim-lsp-installer.
-- --    This makes it available via other APIs (e.g., :LspInstall, lsp_installer.get_available_servers()).
-- servers.register(unified_language_server)

-- Autocomplete
-- require'compe'.setup {
--   enabled = true;
--   autocomplete = true;
--   debug = false;
--   min_length = 1;
--   preselect = 'enable';
--   throttle_time = 80;
--   source_timeout = 200;
--   incomplete_delay = 400;
--   max_abbr_width = 100;
--   max_kind_width = 100;
--   max_menu_width = 100;
--   documentation = true;

--   source = {
--     path = true;
--     nvim_lsp = true;
--     orgmode = true;
--   };
-- }
-- vim.o.completeopt = "menuone,noselect"
-- vim.api.nvim_set_keymap("i", "<C-Space>", "compe#complete()", {expr = true, silent = true})
-- vim.api.nvim_set_keymap("i", "<CR>", "compe#confirm('<CR>')", {expr = true, silent = true})
--
--
-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- nvim-cmp setup
local cmp = require("cmp")
local cmp_buffer = require("cmp_buffer")
cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = function(fallback)
			if vim.fn.pumvisible() == 1 then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-n>", true, true, true), "n")
			else
				fallback()
			end
		end,
		["<S-Tab>"] = function(fallback)
			if vim.fn.pumvisible() == 1 then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-p>", true, true, true), "n")
			else
				fallback()
			end
		end,
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "vsnip" },
		-- Disabled as it required building lua-nuspell which didn't work
		-- { name = "nuspell" },
		-- Disabled as the constant popups are slow
		-- {name = "buffer"}
	},
	formatting = {
		format = require("lspkind").cmp_format({ with_text = true, maxwidth = 50 }),
	},
	comparators = {
		function(...)
			return cmp_buffer:compare_locality(...)
		end,
		-- These are the defaults
		cmp.config.compare.offset,
		cmp.config.compare.exact,
		cmp.config.compare.score,
		cmp.config.compare.recently_used,
		cmp.config.compare.kind,
		cmp.config.compare.sort_text,
		cmp.config.compare.length,
		cmp.config.compare.order,
	},
})

-- Insert ( on complete
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))

local utils = require("telescope.utils")
local builtin = require("telescope.builtin")

-- Falls back to regular if not git directory
_G.project_files = function()
	local _, ret, _ = utils.get_os_command_output({ "git", "rev-parse", "--is-inside-work-tree" })
	if ret == 0 then
		builtin.git_files()
	else
		builtin.find_files()
	end
end

-- VIM Lists
vim.api.nvim_set_keymap("n", "<space>p", "<cmd>lua project_files()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<space>f", "<cmd>lua require('telescope.builtin').live_grep()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<space>m", "<cmd>lua require('telescope.builtin').oldfiles()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<space>l", "<cmd>lua require('telescope.builtin').builtin()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<space>b", "<cmd>lua require('telescope.builtin').buffers()<CR>", { silent = true })
vim.api.nvim_set_keymap(
	"n",
	"<space>/",
	"<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>",
	{ silent = true }
)
vim.api.nvim_set_keymap("n", "<space>h", "<cmd>lua require('telescope.builtin').git_bcommits()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<space>q", "<cmd>lua require('telescope.builtin').quickfix()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<space>r", "<cmd>lua require('telescope.builtin').resume()<CR>", { silent = true })
vim.api.nvim_set_keymap(
	"n",
	"<space>P",
	"<cmd>lua require('telescope').extensions.project.project{}<CR>",
	{ silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<space>t",
	"<cmd>lua require('telescope').extensions.tele_tabby.list{}<CR>",
	{ silent = true }
)

-- Telescope mapping
local actions = require("telescope.actions")
require("telescope").setup({
	defaults = {
		preview = false,
		mappings = {
			i = {
				-- Make escape exit in insert mode as well
				["<esc>"] = actions.close,
			},
		},
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
		},
	},
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("project")
require("telescope").load_extension("tele_tabby")
require("telescope").load_extension("dap")

-- Symbol highlighting
-- vim.api.nvim_command [[ hi def link LspReferenceText CursorLine ]]
-- vim.api.nvim_command [[ hi def link LspReferenceWrite CursorLine ]]
-- vim.api.nvim_command [[ hi def link LspReferenceRead CursorLine ]]

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

-- Autoformat
-- Doing this here rather than per-buffer as there were issues with formatting
-- being disconnected when configured per-buffer.
-- vim.api.nvim_exec([[
-- augroup FormatAutogroup
--   autocmd!
--   autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx,*.py,*.lua,*.html,*.json,*.css,*.c,*.md lua vim.lsp.buf.formatting_sync(nil, 3000)
-- augroup END
-- ]], true)

-- ZK
-- require'lspconfig'.zk.setup{}

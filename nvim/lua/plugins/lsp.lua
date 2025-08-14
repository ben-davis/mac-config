return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'pmizio/typescript-tools.nvim',
      'ray-x/lsp_signature.nvim',
      'b0o/SchemaStore.nvim',
      'nvim-lua/lsp-status.nvim',
      {
        "j-hui/fidget.nvim",
        config = true,
      },
    },
    config = function()
      local lsp_group = vim.api.nvim_create_augroup("LSPKeymaps", {})
      --  This gets run when a LSP client connects to a particular buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "Set custom keymaps and create autocmds",
        pattern = "*",
        group = lsp_group,
        callback = function(ev)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)

          -- helper function for setting up buffer-local keymaps
          local nmap = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = "LSP: " .. desc })
          end

          nmap("<space>s", Snacks.picker.lsp_workspace_symbols, "Workspace [S]ymbols")
          nmap("<space>o", Snacks.picker.lsp_symbols, "Document [S]ymbols")

          nmap("gd", Snacks.picker.lsp_definitions, "[G]oto [D]efinition")
          nmap("gD", Snacks.picker.lsp_declarations, "[G]oto [D]eclarations")
          nmap("gi", Snacks.picker.lsp_implementations, "[G]oto [I]mplementation")
          nmap("gr", Snacks.picker.lsp_references, "[G]oto [R]eferences")
          nmap("gy", Snacks.picker.lsp_type_definitions, "[G]oto T[y]pe definition")

          nmap("<space>R", vim.lsp.buf.rename, "[R]ename")
          nmap("<space>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

          -- Add code nav status bar
          local navic = require("nvim-navic")
          if client.server_capabilities.documentSymbolProvider then
            navic.attach(client, ev.buf)
          end

          -- Add signature help support
          -- require("lsp_signature").on_attach()

          -- Show diagnostics on hover
          vim.api.nvim_create_autocmd("CursorHold", {
            buffer = ev.buf,
            callback = function()
              vim.diagnostic.open_float({ focus = false, source = true })
            end
          })
        end,
      })

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

      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "pyright",
          "ruff",
          "html",
          "jsonls",
          "lua_ls",
          "yamlls",
        },
        automatic_installation = false,
      })

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
        ruff = function(config)
          return config
        end,
        -- ruby_lsp = function(config)
        --   return config
        -- end,
        -- sorbet = function(config)
        --   return config
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
        ccls = function(config)
          return config
        end,
        sourcekit = function(config)
          config.cmd =
          { "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp" }
          return config
        end,
        hls = function(config)
          return config
        end,
      }

      local lsp_lib = require("lib/lsp_lib")
      local default_config = lsp_lib.make_default_config()

      for name, update_config in pairs(servers) do
        local config = {
          on_init = default_config.on_init,
          capabilities = default_config.capabilities,
        }

        if update_config then
          config = update_config(config)
        end

        require("lspconfig")[name].setup(config)
      end

      -- Use typescript-tools
      require("typescript-tools").setup(default_config)
    end
  },
  {
    'hedyhli/outline.nvim',
    config = function()
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
    end

  },
  {
    "rmagatti/goto-preview",
    dependencies = { "rmagatti/logger.nvim" },
    event = "BufEnter",
    config = true, -- necessary as per https://github.com/rmagatti/goto-preview/issues/88
  }
}

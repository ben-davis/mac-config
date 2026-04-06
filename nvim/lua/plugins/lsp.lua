return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "ray-x/lsp_signature.nvim",
      "b0o/SchemaStore.nvim",
      "nvim-lua/lsp-status.nvim",
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

          -- Show diagnostics on hover
          vim.api.nvim_create_autocmd("CursorHold", {
            buffer = ev.buf,
            callback = function()
              vim.diagnostic.open_float({
                focus = false,
                source = true,
                close_events = {
                  "CursorMoved",
                  "CursorMovedI",
                  "BufHidden",
                  "InsertCharPre",
                  "WinLeave",
                },
              })
            end,
          })
        end,
      })

      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "pyright",
          "ruff",
          "html",
          "jsonls",
          "lua_ls",
          "yamlls",
          "vtsls",
          "cssls",
          "css_variables",
          "eslint",
        },
        automatic_installation = false,
        automatic_enable = false,
      })

      -- Global capabilities (cmp_nvim_lsp snippet/completion support)
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      if ok then
        capabilities = vim.tbl_extend("keep", capabilities, cmp_nvim_lsp.default_capabilities())
      end
      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      -- Per-server configurations
      vim.lsp.config("pyright", {
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              diagnosticMode = "workspace",
              useLibraryCodeForTypes = true,
              autoImportCompletions = true,
            },
          },
        },
        on_init = function(client)
          local poetry_env = vim.trim(
            vim.fn.system('cd "' .. client.config.root_dir .. '"; poetry env info -p 2>/dev/null')
          )
          local venv_python_path = client.config.root_dir .. "/.venv/bin/python"

          if vim.fn.filereadable(venv_python_path) == 1 then
            client.config.settings.python.pythonPath = venv_python_path
          elseif poetry_env ~= "" then
            client.config.settings.python.pythonPath = poetry_env .. "/bin/python"
          else
            client.config.settings.python.pythonPath = "/usr/local/opt/python@3.10/libexec/bin/python"
          end

          client.notify("workspace/didChangeConfiguration")
          return true
        end,
      })

      vim.lsp.config("ruff", {
        on_init = function(client)
          client.server_capabilities.hoverProvider = false
          return true
        end,
      })

      vim.lsp.config("jsonls", {
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
          },
        },
      })

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
              path = vim.split(package.path, ";"),
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
            },
          },
        },
      })

      vim.lsp.config("yamlls", {
        filetypes = {
          "yaml",
          "yaml.docker-compose",
        },
        settings = {
          yaml = {
            schemas = require("schemastore").json.schemas(),
          },
        },
      })

      vim.lsp.config("sourcekit", {
        cmd = {
          "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp",
        },
      })

      vim.lsp.enable({
        "pyright",
        "ruff",
        "html",
        "jsonls",
        "lua_ls",
        "yamlls",
        "vtsls",
        "cssls",
        "css_variables",
        "eslint",
        "ccls",
        "sourcekit",
        "hls",
        "gdscript",
      })
    end,
  },
  {
    "hedyhli/outline.nvim",
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
      vim.keymap.set({ "n" }, "<leader>S", ":Outline<CR>", { silent = true, noremap = true })
    end,
  },
  {
    "rmagatti/goto-preview",
    dependencies = { "rmagatti/logger.nvim" },
    event = "BufEnter",
    config = true, -- necessary as per https://github.com/rmagatti/goto-preview/issues/88
  },
}

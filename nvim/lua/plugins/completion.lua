return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'ray-x/cmp-treesitter',
      'hrsh7th/cmp-vsnip',
      'windwp/nvim-autopairs',
      'onsails/lspkind-nvim',
      'hrsh7th/vim-vsnip',
      'hrsh7th/vim-vsnip-integ',
      'rafamadriz/friendly-snippets',
    },
    config = function()
      -- Set completeopt to have a better completion experience
      vim.o.completeopt = "menuone,noselect"

      -- Disabled in favor of nvim-cmp due to lack of color in the completion items
      -- vim.g.coq_settings = {
      -- 	auto_start = true,
      -- 	display = {
      -- 		preview = {
      -- 			positions = {
      -- 				east = 1,
      -- 				west = 2,
      -- 				south = 3,
      -- 				north = 4,
      -- 			},
      -- 		},
      -- 	},
      -- 	keymap = {
      -- 		-- recommended = false,
      -- 		jump_to_mark = "<C-m>",
      -- 		bigger_preview = nil,
      -- 		manual_complete = nil,
      -- 	},
      -- }
      -- nvim-cmp setup
      local cmp = require("cmp")

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
            select = false,
          }),
          ["<Tab>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          }),
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "treesitter" },
          { name = "vsnip" },
          { name = "path" },
          -- Disabled as it required building lua-nuspell which didn't work
          -- { name = "nuspell" },
          -- Disabled as the constant popups are slow
          -- {name = "buffer"}
        },
        formatting = {
          format = require("lspkind").cmp_format({ with_text = true, maxwidth = 50 }),
        },
        comparators = {
          cmp.config.compare.locality,
          cmp.config.compare.scopes,
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.score,
          cmp.config.compare.recently_used,
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
        experimental = {
          ghost_text = true,
        },
      })

      -- Insert ( on complete
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))

      -- Use dadbod on sql files
      vim.api.nvim_exec(
        [[
          augroup dadbod-completion
            autocmd!
            autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
          augroup END
        ]],
        true
      )
    end
  }
}

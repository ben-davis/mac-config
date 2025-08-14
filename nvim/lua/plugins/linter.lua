return {
  {
    'mfussenegger/nvim-lint',
    config = function()
      require("lint").linters_by_ft = {
        -- markdown = { "vale" },
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
      }
    end
  } }

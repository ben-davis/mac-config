return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/nvim-nio",
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-jest",
      "olimorris/neotest-rspec",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python")({}),
          require("neotest-rspec")({
            transform_spec_path = function(path)
              -- Pass the spec file as a relative file, not absolute
              local prefix = require("neotest-rspec").root(path)
              return string.sub(path, string.len(prefix) + 2, -1)
            end,

            formatter = "json",
          }),
          require("neotest-jest"),
        },
      })

      -- Set keymap in a separate file so that we can override this plugin spec (which I do at work)
      require("lib/neo-test-lib").set_keymap()
    end,
  },
}

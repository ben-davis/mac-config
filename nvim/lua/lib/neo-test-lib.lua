local M = {}

M.set_keymap = function()
  -- Register prefix descriptions
  vim.keymap.set("n", "<Leader>t", "", { desc = "[T]est" })

  -- Test once
  vim.keymap.set("n", "<Leader>tn", function()
    require("neotest").run.run()
  end, { noremap = true, silent = true, desc = "[T]est [n]earest" })

  vim.keymap.set("n", "<Leader>ta", function()
    require("neotest").run.attach()
  end, { noremap = true, silent = true, desc = "[T]est [a]ttach" })

  vim.keymap.set("n", "<Leader>tf", function()
    require("neotest").run.run(vim.fn.expand("%"))
  end, { noremap = true, silent = true, desc = "[T]est [f]ile" })

  vim.keymap.set("n", "<Leader>tl", function()
    require("neotest").run.run_last()
  end, { noremap = true, silent = true, desc = "[T]est [l]ast" })

  vim.keymap.set("n", "<Leader>ts", function()
    require("neotest").run.run({ suite = true })
  end, { noremap = true, silent = true, desc = "[T]est [s]uite" })

  -- Debug
  vim.keymap.set("n", "<Leader>tdn", function()
    require("neotest").run.run({ strategy = "dap" })
  end, { noremap = true, silent = true, desc = "[T]est [d]ebug [n]earest" })

  vim.keymap.set("n", "<Leader>tdf", function()
    require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" })
  end, { noremap = true, silent = true, desc = "[T]est [d]ebug [f]ile" })

  vim.keymap.set("n", "<Leader>tdl", function()
    require("neotest").run.run_last({ strategy = "dap" })
  end, { noremap = true, silent = true, desc = "[T]est [d]ebug [l]ast" })

  vim.keymap.set("n", "<Leader>tds", function()
    require("neotest").run.run({ suite = true, strategy = "dap" })
  end, { noremap = true, silent = true, desc = "[T]est [d]ebug [s]uite" })

  -- Watch
  vim.keymap.set("n", "<Leader>twn", function()
    require("neotest").watch.toggle()
  end, { noremap = true, silent = true, desc = "[T]est [w]atch [n]earest" })

  vim.keymap.set("n", "<Leader>twf", function()
    require("neotest").watch.toggle(vim.fn.expand("%"))
  end, { noremap = true, silent = true, desc = "[T]est [w]atch [f]ile" })

  -- UI
  vim.keymap.set("n", "<Leader>tS", function()
    require("neotest").run.run({ suite = true })
  end, { noremap = true, silent = true, desc = "[T]est [S]ummary" })

  vim.keymap.set("n", "<Leader>to", function()
    require("neotest").output.open({ enter = true })
  end, { noremap = true, silent = true, desc = "[T]est [o]utput" })

  vim.keymap.set("n", "<Leader>tO", function()
    require("neotest").output_panel.open()
  end, { noremap = true, silent = true, desc = "[T]est [O]utput panel" })
end

return M

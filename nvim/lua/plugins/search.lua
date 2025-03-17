return {
  {
    "nvim-pack/nvim-spectre",
    config = function()
      -- Search and replace
      vim.keymap.set("n", "<leader>S", ":lua require('spectre').open()<CR>", { noremap = true })
    end
  }
}

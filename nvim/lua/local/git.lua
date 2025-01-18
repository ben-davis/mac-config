-- Git signs
require("gitsigns").setup()

-- Diffview
vim.keymap.set({ "n" }, "<leader>gl", ":DiffviewFileHistory<CR>", { silent = true, noremap = true })
vim.keymap.set({ "n" }, "<leader>gh", ":DiffviewFileHistory %<CR>", { silent = true, noremap = true })
vim.keymap.set({ "n" }, "<leader>gd", ":DiffviewOpen <CR>", { silent = true, noremap = true })

-- Neogit
vim.keymap.set({ "n" }, "<leader>gs", ":Neogit <CR>", { silent = true, noremap = true })

-- Git messenger (blame)
vim.g["git_messenger_no_default_mappings"] = true
vim.keymap.set({ "n" }, "<leader>gm", "<Plug>(git-messenger)", { silent = true, noremap = true })


require("diffview")
require("gitlab").setup()

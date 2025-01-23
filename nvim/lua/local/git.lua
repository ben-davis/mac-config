-- Git signs
require("gitsigns").setup()

-- Diffview
vim.keymap.set(
	{ "n" },
	"<leader>gl",
	":DiffviewFileHistory<CR>",
	{ silent = true, noremap = true, desc = "Repo history" }
)
vim.keymap.set(
	{ "n" },
	"<leader>gh",
	":DiffviewFileHistory --follow %<CR>",
	{ silent = true, noremap = true, desc = "File history" }
)
vim.keymap.set(
	{ "v" },
	"<leader>gh",
	"<Esc><Cmd>'<,'>DiffviewFileHistory --follow<CR>",
	{ silent = true, noremap = true, desc = "Range history" }
)
vim.keymap.set(
	{ "n" },
	"<leader>g.",
	"<Cmd>.DiffviewFileHistory --follow<CR>",
	{ silent = true, noremap = true, desc = "Line history" }
)
vim.keymap.set({ "n" }, "<leader>gd", ":DiffviewOpen <CR>", { silent = true, noremap = true, desc = "Diff worktree" })

-- Neogit
vim.keymap.set({ "n" }, "<leader>gs", ":Neogit <CR>", { silent = true, noremap = true, desc = "Git status" })

-- Git messenger (blame)
vim.g["git_messenger_no_default_mappings"] = true
vim.keymap.set({ "n" }, "<leader>gm", "<Plug>(git-messenger)", { silent = true, noremap = true, desc = "Git blame" })

require("diffview")
require("gitlab").setup()

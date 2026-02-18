-- Clear highlighting on escape in normal mode
vim.keymap.set("n", "<esc>", ":noh<return><esc>", { noremap = true, silent = true })

-- nnoremap <esc>^[ <esc>^[

-- Change enter to new line in normal mode
-- Shift-enter for new line above.
vim.keymap.set("n", "<CR>", "o<esc>", { noremap = true })
vim.keymap.set("n", "<S-CR>", "O<esc>", { noremap = true })
vim.keymap.set("i", "<S-CR>", "<esc>O", { noremap = true })

-- Change visual paste to not yank the deleted characters
vim.keymap.set("v", "p", '"_dP', { noremap = true })

-- Normal/insert mode movement
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true })

-- Terminal mode movement
vim.keymap.set("t", "<C-h>", "<C-\\><C-N><C-w>h", { noremap = true })
vim.keymap.set("t", "<C-j>", "<C-\\><C-N><C-w>j", { noremap = true })
vim.keymap.set("t", "<C-k>", "<C-\\><C-N><C-w>k", { noremap = true })
vim.keymap.set("t", "<C-l>", "<C-\\><C-N><C-w>l", { noremap = true })

-- Easier escape from terminal
vim.keymap.set("t", "<leader><Esc>", "<C-\\><C-n>", { noremap = true })

-- Use gx to open URLs.
vim.keymap.set("n", "gx", ":!open <cWORD><cr>", { noremap = true })

-- Delete buffer
vim.keymap.set("n", "<leader>q", ":Bdelete<CR>", { noremap = true, silent = true })

-- Y yank until the end of line
vim.keymap.set("n", "Y", "y$", { noremap = true, silent = true })

-- Yank relative path
vim.keymap.set("n", "<leader>yp", ":let @+ = expand('%:p')<CR>", { desc = "Copy full path to clipboard" })
vim.keymap.set("n", "<leader>yr", ":let @+ = expand('%')<CR>", { desc = "Copy relative path to clipboard" })

-- Set movement to always go to visual lines, rather than real lines
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- Easier tab management
vim.keymap.set({ "n", "t" }, "<leader>n", ":tabnew<CR>", { noremap = true, silent = true })
vim.keymap.set({ "n", "t" }, "<leader>C", ":tabclose<CR>", { noremap = true, silent = true })

-- Quickfix navigation
vim.keymap.set("n", "]q", ":cnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "[q", ":cprev<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "[Q", ":cfirst<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "]Q", ":clast<CR>", { noremap = true, silent = true })

-- Diagnostic navigation
vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", { noremap = true, silent = true })

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

-- Copy to clipboard
vim.keymap.set("v", "<leader>y", ":OSCYank<CR>", { noremap = true })

-- Paste from clipboard
vim.keymap.set("n", "<leader>p", '"+p', { noremap = true })
vim.keymap.set("n", "<leader>P", '"+P', { noremap = true })
vim.keymap.set("v", "<leader>p", '"+p', { noremap = true })
vim.keymap.set("v", "<leader>P", '"+P', { noremap = true })

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

vim.keymap.set("n", "<leader>l", ":LazyGit<CR>", { noremap = true, silent = true })
-- let g:lazygit_floating_window_use_plenary = 1

-- Delete buffer
vim.keymap.set("n", "<leader>q", ":Bdelete<CR>", { noremap = true, silent = true })

-- Y yank until the end of line
vim.keymap.set("n", "Y", "y$", { noremap = true, silent = true })

-- Search and replace
vim.keymap.set("n", "<leader>S", ":lua require('spectre').open()<CR>", { noremap = true })

-- Set movement to always go to visual lines, rather than real lines
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- Easier tab management
vim.keymap.set({ "n", "t" }, "<leader>n", ":tabnew<CR>", { noremap = true, silent = true })
vim.keymap.set({ "n", "t" }, "<leader>c", ":tabclose<CR>", { noremap = true, silent = true })

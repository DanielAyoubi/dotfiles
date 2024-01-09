-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Replace <C-BS> with <C-W> in insert mode
vim.api.nvim_set_keymap("i", "<C-BS>", "<C-W>", { noremap = true })

-- Replace <C-h> with <C-W> in insert mode
vim.api.nvim_set_keymap("i", "<C-h>", "<C-W>", { noremap = true })

-- Replace <C-BS> with <C-W> in insert mode
vim.api.nvim_set_keymap("i", "<C-BS>", "<C-W>", { noremap = true })

-- Set LineNr highlight to white
vim.cmd("highlight LineNr ctermfg=white")

-- Replace <C-@> with <C-y> in insert mode
vim.api.nvim_set_keymap("i", "<C-@>", "<C-y>", { noremap = true })

-- Map 'd' to "_d in normal mode (black hole register)
vim.api.nvim_set_keymap("n", "d", '"_d', { noremap = true })

-- Map 'd' to "_d in visual mode (black hole register)
vim.api.nvim_set_keymap("v", "d", '"_d', { noremap = true })

-- Map 'x' to "_x in normal mode (black hole register)
vim.api.nvim_set_keymap("n", "x", '"_x', { noremap = true })

-- Map 'x' to "_x in visual mode (black hole register)
vim.api.nvim_set_keymap("v", "x", '"_x', { noremap = true })

vim.api.nvim_set_keymap("n", "<C-a>", "<Esc>ggVG<CR>", { noremap = true })

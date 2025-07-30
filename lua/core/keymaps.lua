vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = require("helpers.keys").map

-- Save
map("n", "<C-s>", "<cmd>:w<cr>", "Save Buffer")

-- Format
map("n", "<M-S-f>", "<cmd>lua vim.lsp.buf.format()<cr>", "Format Buffer")
map("n", "<M-f>", "<cmd>lua vim.lsp.buf.format()<cr>", "Format Buffer")

-- Hide search
map("n", "<leader>/", "<cmd>:noh<cr>", "Hide search")

-- Stay in indent mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Better window navigation
map("n", "<C-h>", "<C-w><C-h>", "Navigate windows to the left")
map("n", "<C-j>", "<C-w><C-j>", "Navigate windows down")
map("n", "<C-k>", "<C-w><C-k>", "Navigate windows up")
map("n", "<C-l>", "<C-w><C-l>", "Navigate windows to the right")
map("n", "<C-q>", "<C-w><C-q>", "Close window")

-- Move with shift-arrows
map("n", "<S-Left>", "<C-w><S-h>", "Move window to the left")
map("n", "<S-Down>", "<C-w><S-j>", "Move window down")
map("n", "<S-Up>", "<C-w><S-k>", "Move window up")
map("n", "<S-Right>", "<C-w><S-l>", "Move window to the right")

-- Resize with arrows
map("n", "<C-Up>", ":resize +2<CR>")
map("n", "<C-Down>", ":resize -2<CR>")
map("n", "<C-Left>", ":vertical resize +2<CR>")
map("n", "<C-Right>", ":vertical resize -2<CR>")

-- Deleting buffers
local buffers = require("helpers.buffers")
map("n", "<leader>x", buffers.delete_this, "Close Current buffer")
-- map("n", "<leader>do", buffers.delete_others, "Other buffers")
-- map("n", "<leader>da", buffers.delete_all, "All buffers")

-- Navigate buffers
map("n", "<leader>j", ":bnext<CR>")
map("n", "<leader>k", ":bprevious<CR>")

-- Other
map("n", "<leader>mm", "<cmd>messages<cr>", "Show Messages")
map("n", "<leader>il", "<cmd>LspInfo<cr>", "Show LSP Info")
map("n", "<leader>in", "<cmd>NullLsInfo<cr>", "Show NullLS Info")

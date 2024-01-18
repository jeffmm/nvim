-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- buffers
vim.keymap.set("n", "<c-n>", ":bn<cr>", { desc = "next buffer" })
vim.keymap.set("n", "<c-p>", ":bp<cr>", { desc = "prev buffer" })
vim.keymap.set("n", "<c-x>", ":bd<cr>", { desc = "exit buffer" })

vim.keymap.set("n", "J", "10gj")
vim.keymap.set("n", "K", "10gk")
vim.keymap.set("v", "J", "10gj")
vim.keymap.set("v", "K", "10gk")

vim.keymap.set("n", "H", "^")
vim.keymap.set("n", "L", "$")
vim.keymap.set("v", "H", "^")
vim.keymap.set("v", "L", "$")

-- delete lazy keymaps
vim.keymap.del("n", "<S-h>") -- , "<cmd>bprevious<cr>", { desc = "Prev buffer" })
vim.keymap.del("n", "<S-l>") -- , "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.del("n", "[b") -- "<cmd>bprevious<cr>", { desc = "Prev buffer" })
vim.keymap.del("n", "]b") -- "<cmd>bnext<cr>") -- , { desc = "Next buffer" })
vim.keymap.del("n", "<leader>bb") -- , "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
vim.keymap.del("n", "<leader>`") -- , "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- remove highlighting
vim.keymap.set("n", "<esc><esc>", ":nohlsearch<cr>", { desc = "remove highlighting", silent = true })

-- the worst place in the universe
vim.keymap.set("n", "Q", "<nop>")

-- move to text buffer
vim.keymap.set("n", "<TAB>", ":bnext<CR>", { silent = true })
vim.keymap.set("n", "<S-TAB>", ":bprevious<CR>", { silent = true })

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- move blocks
vim.keymap.set("v", "<c-j>", ":m '>+1<CR>gv=gv", { desc = "move block up" })
vim.keymap.set("v", "<c-k>", ":m '<-2<CR>gv=gv", { desc = "move block down"})

-- focus scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "scroll down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "scroll up" })

-- focus highlight searches
vim.keymap.set("n", "n", "nzzzv", { desc = "next match" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "prev match" })

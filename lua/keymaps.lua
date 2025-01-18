-- [[ Keymaps ]]
--  See `:help map()`

local map = vim.keymap.set

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
map('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Escape and clear search' })

-- Diagnostic keymaps
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- better up/down
map({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ 'n', 'x' }, '<Down>', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ 'n', 'x' }, '<Up>', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- move to text buffer
map('n', '<TAB>', ':bnext<CR>', { silent = true })
map('n', '<S-TAB>', ':bprevious<CR>', { silent = true })

-- better indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- move blocks
map('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'move block up' })
map('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'move block down' })

-- scrolling
map('n', '<C-j>', '<C-d>', { desc = 'scroll down' })
map('n', '<C-k>', '<C-u>', { desc = 'scroll up' })
map('v', '<C-j>', '<C-d>', { desc = 'scroll down' })
map('v', '<C-k>', '<C-u>', { desc = 'scroll up' })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map('n', 'n', "'Nn'[v:searchforward].'zv'", { expr = true, desc = 'Next Search Result' })
map('x', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next Search Result' })
map('o', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next Search Result' })
map('n', 'N', "'nN'[v:searchforward].'zv'", { expr = true, desc = 'Prev Search Result' })
map('x', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev Search Result' })
map('o', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev Search Result' })

-- Lazy
map('n', '<leader>L', '<cmd>Lazy<cr>', { desc = 'Lazy' })

-- new file
-- map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- [[ Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- remove trailing whitespaces and ^M chars
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  pattern = { '*' },
  callback = function(_)
    local save_cursor = vim.fn.getpos '.'
    vim.cmd [[%s/\s\+$//e]]
    vim.fn.setpos('.', save_cursor)
  end,
})

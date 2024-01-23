-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- remove trailing whitespaces and ^M chars
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  callback = function(_)
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
})

vim.api.nvim_create_autocmd({ "BufNewFile" }, {
  pattern = "*.ipynb",
  command = "0r " .. vim.fn.stdpath("config") .. "/skeletons/jupyter.sk",
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "*.ipynb",
  command = vim.cmd([[set formatoptions-=ro]]),
})

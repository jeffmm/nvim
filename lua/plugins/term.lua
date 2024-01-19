vim.keymap.set("n", "<leader>tP", function()
  require("lazy.util").float_term({ "top" })
end, { desc = "top" })
vim.keymap.set("n", "<leader>tp", function()
  require("lazy.util").float_term({ "python" })
end, { desc = "python" })
vim.keymap.set("n", "<leader>gl", function()
  require("lazy.util").float_term({ "lazygit" })
end, { desc = "lazygit" })
vim.keymap.set("n", "<leader>tg", function()
  require("lazy.util").float_term({ "lazygit" })
end, { desc = "lazygit" })

return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      vim.keymap.set("n", "<leader>tt", ":ToggleTerm<CR>", { desc = "terminal", silent = true })
      vim.keymap.set("n", "<leader>tT", ":ToggleTerm direction=vertical<CR>", { desc = "terminal", silent = true })
      function _G.set_terminal_keymaps()
        local opts = { buffer = 0 }
        vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
        vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
      end

      vim.cmd("autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()")
      require("toggleterm").setup({
        shade_terminals = false,
        direction = "horizontal",
        close_on_exit = true, -- close the terminal window when the process exits
        size = function(term)
          if term.direction == "horizontal" then
            return 20
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
      })
    end,
  },
}

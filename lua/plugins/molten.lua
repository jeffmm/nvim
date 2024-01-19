return {
  "benlubas/molten-nvim",
  dependencies = "3rd/image.nvim",
  build = ":UpdateRemotePlugins",
  ft = { "python", "julia" },
  init = function()
    vim.g.molten_image_provider = "image.nvim"

    -- Output Window
    vim.g.molten_auto_open_output = false
    vim.g.molten_output_win_max_height = 30

    -- Virtual Text
    vim.g.molten_virt_text_output = true
  end,
  config = function()
    local keymap = vim.keymap.set
    keymap("n", "<leader>jo", "<CMD>MoltenEvaluateOperator<CR>", { desc = "Evaluate Operator" })
    keymap("n", "<leader>jl", "<CMD>MoltenEvaluateLine<CR>", { desc = "Evaluate Line" })
    keymap("n", "<leader>jr", "<CMD>MoltenReevaluateCell<CR>", { desc = "Re-evaluate cell" })
    keymap("n", "<leader>jd", "<CMD>MoltenDelete<CR>", { desc = "Delete cell" })
    keymap("n", "<leader>js", "<CMD>MoltenEnterOutput<CR>", { desc = "Show/enter output window" })
    keymap("n", "<leader>jh", "<CMD>MoltenHideOutput<CR>", { desc = "Hide output window" })
    keymap("n", "<leader>jj", "<CMD>MoltenNext<CR>", { desc = "Goto next cell" })
    keymap("n", "<leader>jk", "<CMD>MoltenPrev<CR>", { desc = "Goto prev cell" })
    keymap("v", "O", ":<C-u>MoltenEvaluateVisual<CR>", { desc = "Evaluate visual selection" })
  end,
}

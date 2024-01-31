return {
  "linux-cultist/venv-selector.nvim",
  event = "VeryLazy",
  dependencies = {
    "neovim/nvim-lspconfig",
    "nvim-telescope/telescope.nvim",
  },
  cmd = "VenvSelect",
  config = function()
    vim.keymap.set("n", "<leader>v", "<cmd>VenvSelect<CR>", { desc = "virtual envs" })
    require("venv-selector").setup({
      path = "~/Projects/.virtualenvs",
      search = true,
      parents = 0,
    })
    vim.api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
      desc = "Venv autoselect",
      pattern = "*",
      callback = function()
        if vim.fn.findfile("pyproject.toml", vim.fn.getcwd() .. ";") ~= "" then
          require("venv-selector").retrieve_from_cache()
        end
      end,
      once = true,
    })
  end,
}

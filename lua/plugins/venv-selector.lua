return {
  "linux-cultist/venv-selector.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-dap",
    "mfussenegger/nvim-dap-python", --optional
    { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
  },
  lazy = false,
  branch = "regexp", -- This is the regexp branch, use this for the new version
  config = function()
    vim.keymap.set("n", "<leader>v", "<cmd>VenvSelect<cr>", { desc = "virtual envs" })
    require("venv-selector").setup({
      path = "~/Projects/.virtualenvs",
      search = {
        project_venvs = {
          command = "fd python$ ~/Projects/.virtualenvs/",
        },
      },
      parents = 0,
    })
    -- vim.api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
    --   desc = "Venv autoselect",
    --   pattern = "*",
    --   callback = function()
    --     if vim.fn.findfile("pyproject.toml", vim.fn.getcwd() .. ";") ~= "" then
    --       require("venv-selector").retrieve_from_cache()
    --     end
    --   end,
    --   once = true,
    -- })
  end,
}

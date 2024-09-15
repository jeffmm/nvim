return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    plugins = {
      spelling = {
        enabled = true,
        suggestions = 20,
      },
    },
    win = {
      border = "shadow",
      -- position = "bottom",
      -- margin = { 0, 1, 1, 5 },
      padding = { 1, 2, 1, 2 },
    },
    spec = {
      { "<leader>'", group = "marks" },
      { "<leader>/", group = "search" },
      { "<leader>/g", group = "git" },
      { "<leader>/gd", group = "diff" },
      { "<leader>;", group = "test" },
      { "<leader><tab>", group = "tabs" },
      { "<leader>[", group = "previous" },
      { "<leader>]", group = "next" },
      { "<leader>b", group = "buffer" },
      { "<leader>d", group = "debug" },
      { "<leader>l", group = "lsp" },
      { "<leader>m", group = "macro/markdown" },
      { "<leader>n", group = "notifications" },
      { "<leader>r", group = "refactor" },
      { "<leader>s", group = "search" },
      { "<leader>t", group = "test" },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}

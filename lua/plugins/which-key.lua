return {
  "folke/which-key.nvim",
  -- event = "VeryLazy",
  keys = {
    {
      "<leader>",
    },
  },
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
    triggers_nowait = {
      "`",
      "'",
      "g`",
      "g'",
      '"',
      "<c-r>",
      "z=",
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
}

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
      presets = {
        windows = false,
      },
    },
    win = {
      border = "shadow",
      -- position = "bottom",
      -- margin = { 0, 1, 1, 5 },
      padding = { 1, 2, 1, 2 },
    },
    spec = {
      { "<leader>p", group = "Pomodoro" },
    },
  },
}

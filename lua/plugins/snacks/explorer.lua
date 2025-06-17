return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    explorer = { enabled = true },
  },
  keys = {
    {
      "<leader>e",
      function()
        require("snacks").explorer()
      end,
      desc = "[E]xplorer",
      silent = true,
    },
  },
}

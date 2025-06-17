return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    zen = { enabled = true },
  },
  keys = {
    {
      "<leader>z",
      function()
        require("snacks").zen()
      end,
      desc = "Toggle Zen Mode",
    },
    {
      "<leader>Z",
      function()
        require("snacks").zen.zoom()
      end,
      desc = "Toggle Zoom",
    },
  },
}

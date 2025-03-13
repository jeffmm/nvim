local diff_config = {
  enabled = true,
  close_chat_at = 50, -- Close an open chat buffer if the total columns of your display are less than...
  layout = "vertical", -- vertical|horizontal split for default provider
  opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
  provider = "mini_diff", -- default|mini_diff
}

return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      { "<leader>a", mode = { "n", "v" }, desc = "CodeCompanion", group = "CodeCompanion" },
      {
        "<leader>aa",
        function()
          vim.cmd("CodeCompanionActions")
        end,
        mode = { "n", "v" },
        desc = "Actions",
      },
      {
        "<leader>ac",
        function()
          vim.cmd("CodeCompanionChat")
        end,
        mode = { "n" },
        desc = "Chat",
      },
      {
        "<leader>ac",
        function()
          vim.cmd("CodeCompanionChat")
        end,
        mode = { "v" },
        desc = "Add to Chat",
      },
    },
    opts = {
      strategies = {
        chat = {
          adapter = "anthropic",
          diff = diff_config,
        },
        inline = {
          adapter = "anthropic",
          layout = "vertical", -- vertical|horizontal|buffer
          keymaps = {
            accept_change = {
              modes = { n = "ga" },
              description = "Accept the suggested change",
            },
            reject_change = {
              modes = { n = "gr" },
              description = "Reject the suggested change",
            },
          },
          diff = diff_config,
        },
      },
    },
  },
}

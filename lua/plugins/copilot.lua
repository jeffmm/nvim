local diff_config = {
  enabled = true,
  close_chat_at = 50, -- Close an open chat buffer if the total columns of your display are less than...
  layout = "vertical", -- vertical|horizontal split for default provider
  opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
  provider = "mini_diff", -- default|mini_diff
}

return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    opts = {
      suggestion = {
        enabled = not vim.g.ai_cmp,
        auto_trigger = true,
        keymap = {
          accept = false, -- handled by nvim-cmp / blink.cmp
          next = "<C-l>",
          prev = "<C-h>",
        },
      },
      panel = { enabled = true },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
  { "giuxtaposition/blink-cmp-copilot" },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      {
        "<leader>aa",
        function()
          vim.cmd("CodeCompanionActions")
        end,
        mode = { "n", "v" },
      },
      {
        "<leader>ac",
        function()
          vim.cmd("CodeCompanionChat")
        end,
        mode = { "n", "v" },
      },
      {
        "ga",
        function()
          vim.cmd("CodeCompanionChat Add")
        end,
        mode = { "v" },
      },
    },
    config = {
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

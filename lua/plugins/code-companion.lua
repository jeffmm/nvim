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
      {
        "Davidyz/VectorCode",
        version = "*", -- optional, depending on whether you're on nightly or release
        build = "uv tool upgrade vectorcode", -- optional but recommended. This keeps your CLI up-to-date.
        dependencies = { "nvim-lua/plenary.nvim" },
      },
      {
        "ravitemer/mcphub.nvim",
        build = "npm install -g mcp-hub@latest",
        opts = { native_servers = {} },
      },
      "ravitemer/codecompanion-history.nvim",
    },
    keys = {
      { "<leader>a", mode = { "n", "v" }, group = "CodeCompanion" },
      {
        "<leader>aa",
        function()
          vim.cmd("CodeCompanionActions")
        end,
        mode = { "n", "v" },
        desc = "[A]ctions",
      },
      {
        "<leader>an",
        function()
          vim.cmd("CodeCompanionChat")
        end,
        mode = { "n" },
        desc = "[N]ew Chat",
      },
      {
        "<leader>ac",
        function()
          vim.cmd("CodeCompanionChat Toggle")
        end,
        mode = { "n" },
        desc = "[C]hat",
      },
      {
        "<leader>am",
        function()
          vim.cmd("MCPHub")
        end,
        mode = { "n" },
        desc = "[M]CP",
      },
      {
        "<leader>ap",
        function()
          require("copilot.suggestion").toggle_auto_trigger()
        end,
        mode = { "n" },
        desc = "Co[P]ilot",
      },

      {
        "<leader>ac",
        function()
          vim.cmd("CodeCompanionChat")
        end,
        mode = { "v" },
        desc = "Add to [C]hat",
      },
    },
    opts = {
      strategies = {
        chat = {
          adapter = "gemini",
          diff = diff_config,
        },
        inline = {
          adapter = "gemini",
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
      extensions = {
        history = {
          enabled = true,
          opts = {
            -- Keymap to open history from chat buffer (default: gh)
            keymap = "gh",
            -- Keymap to save the current chat manually (when auto_save is disabled)
            save_chat_keymap = "sc",
            -- Save all chats by default (disable to save only manually using 'sc')
            auto_save = true,
            -- Number of days after which chats are automatically deleted (0 to disable)
            expiration_days = 0,
            -- Picker interface (auto resolved to a valid picker)
            picker = "telescope", --- ("telescope", "snacks", "fzf-lua", or "default")
            ---Automatically generate titles for new chats
            auto_generate_title = true,
            title_generation_opts = {
              ---Adapter for generating titles (defaults to current chat adapter)
              adapter = nil, -- "copilot"
              ---Model for generating titles (defaults to current chat model)
              model = nil, -- "gpt-4o"
              ---Number of user prompts after which to refresh the title (0 to disable)
              refresh_every_n_prompts = 0, -- e.g., 3 to refresh after every 3rd user prompt
              ---Maximum number of times to refresh the title (default: 3)
              max_refreshes = 3,
            },
            ---On exiting and entering neovim, loads the last chat on opening chat
            continue_last_chat = false,
            ---When chat is cleared with `gx` delete the chat from history
            delete_on_clearing_chat = false,
            ---Directory path to save the chats
            dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
            ---Enable detailed logging for history extension
            enable_logging = true,
            ---Optional filter function to control which chats are shown when browsing
            chat_filter = nil, -- function(chat_data) return boolean end
          },
          -- opts = {
          --     -- Keymap to open history from chat buffer (default: gh)
          --     keymap = "gh",
          --     -- Keymap to save the current chat manually (when auto_save is disabled)
          --     save_chat_keymap = "sc",
          --     -- Save all chats by default (disable to save only manually using 'sc')
          --     auto_save = true,
          --     -- Number of days after which chats are automatically deleted (0 to disable)
          --     expiration_days = 0,
          --     -- Picker interface ("telescope" or "snacks" or "fzf-lua" or "default")
          --     picker = "telescope",
          --     ---Automatically generate titles for new chats
          --     auto_generate_title = true,
          --     title_generation_opts = {
          --       ---Adapter for generating titles (defaults to active chat's adapter)
          --       adapter = nil, -- e.g "copilot"
          --       ---Model for generating titles (defaults to active chat's model)
          --       model = nil, -- e.g "gpt-4o"
          --     },
          --     ---On exiting and entering neovim, loads the last chat on opening chat
          --     continue_last_chat = false,
          --     ---When chat is cleared with `gx` delete the chat from history
          --     delete_on_clearing_chat = false,
          --     ---Directory path to save the chats
          --     dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
          --     ---Enable detailed logging for history extension
          --     enable_logging = true,
          --   },
        },
        vectorcode = {
          opts = {
            add_tool = true,
          },
        },
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            show_result_in_chat = true, -- Show mcp tool results in chat
            make_vars = true, -- Convert resources to #variables
            make_slash_commands = true, -- Add prompts as /slash commands
          },
        },
      },
    },
  },
}

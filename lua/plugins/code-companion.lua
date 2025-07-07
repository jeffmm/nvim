local enable_plugin = true
local diff_config = {
  enabled = enable_plugin,
  close_chat_at = 50, -- Close an open chat buffer if the total columns of your display are less than...
  layout = "vertical", -- vertical|horizontal split for default provider
  opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
  provider = "mini_diff", -- default|mini_diff
}

return {
  {
    "olimorris/codecompanion.nvim",
    lazy = true,
    enabled = enable_plugin,
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
        opts = {
          --- `mcp-hub` binary related options-------------------
          config = vim.fn.expand("~/.config/mcphub/servers.json"), -- Absolute path to MCP Servers config file (will create if not exists)
          port = 37373, -- The port `mcp-hub` server listens to
          shutdown_delay = 60 * 10 * 000, -- Delay in ms before shutting down the server when last instance closes (default: 10 minutes)
          use_bundled_binary = false, -- Use local `mcp-hub` binary (set this to true when using build = "bundled_build.lua")
          mcp_request_timeout = 1000000, --Max time allowed for a MCP tool or resource to execute in milliseconds, set longer for long running tasks

          ---Chat-plugin related options-----------------
          auto_approve = false, -- Auto approve mcp tool calls
          auto_toggle_mcp_servers = true, -- Let LLMs start and stop MCP servers automatically
          extensions = {}, -- Handled by codecompanion

          --- Plugin specific options-------------------
          native_servers = {}, -- add your custom lua native servers here
          ui = {
            window = {
              width = 0.8, -- 0-1 (ratio); "50%" (percentage); 50 (raw number)
              height = 0.8, -- 0-1 (ratio); "50%" (percentage); 50 (raw number)
              align = "center", -- "center", "top-left", "top-right", "bottom-left", "bottom-right", "top", "bottom", "left", "right"
              relative = "editor",
              zindex = 50,
              border = "rounded", -- "none", "single", "double", "rounded", "solid", "shadow"
            },
            wo = { -- window-scoped options (vim.wo)
              winhl = "Normal:MCPHubNormal,FloatBorder:MCPHubBorder",
            },
          },
          on_ready = function(hub)
            -- Called when hub is ready
          end,
          on_error = function(err)
            -- Called on errors
          end,
          log = {
            level = vim.log.levels.WARN,
            to_file = false,
            file_path = nil,
            prefix = "MCPHub",
          },
        },
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
          enabled = enable_plugin,
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
        },
        vectorcode = {
          enabled = enable_plugin,
          opts = {
            tool_group = {
              -- this will register a tool group called `@vectorcode_toolbox` that contains all 3 tools
              enabled = true,
              -- a list of extra tools that you want to include in `@vectorcode_toolbox`.
              -- if you use @vectorcode_vectorise, it'll be very handy to include
              -- `file_search` here.
              extras = {},
              collapse = false, -- whether the individual tools should be shown in the chat
            },
            tool_opts = {
              ---@type VectorCode.CodeCompanion.ToolOpts
              ["*"] = {},
              ---@type VectorCode.CodeCompanion.LsToolOpts
              ls = {},
              ---@type VectorCode.CodeCompanion.VectoriseToolOpts
              vectorise = {},
              ---@type VectorCode.CodeCompanion.QueryToolOpts
              query = {
                max_num = { chunk = -1, document = -1 },
                default_num = { chunk = 50, document = 10 },
                include_stderr = false,
                use_lsp = false,
                no_duplicate = true,
                chunk_mode = false,
                ---@type VectorCode.CodeCompanion.SummariseOpts
                summarise = {
                  ---@type boolean|(fun(chat: CodeCompanion.Chat, results: VectorCode.QueryResult[]):boolean)|nil
                  enabled = false,
                  adapter = nil,
                  query_augmented = true,
                },
              },
              files_ls = {},
              files_rm = {},
            },
          },
        },
        mcphub = {
          enabled = enable_plugin,
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

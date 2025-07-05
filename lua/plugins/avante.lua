return {
  "yetone/avante.nvim",
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  -- ⚠️ must add this setting! ! !
  build = function()
    return "make BUILD_FROM_SOURCE=true"
  end,
  event = "VeryLazy",
  keys = {
    {
      "<leader>am",
      function()
        vim.cmd("MCPHub")
      end,
      mode = { "n" },
      desc = "[M]CP",
    },
  },
  version = false, -- Never set this value to "*"! Never!
  ---@module 'avante'
  ---@type avante.Config

  opts = {
    ---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
    ---@type Provider
    provider = "gemini",
    providers = {
      claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-sonnet-4-20250514",
        timeout = 120000, -- Timeout in milliseconds
        context_window = 200000,
        extra_request_body = {
          temperature = 0.75,
          max_tokens = 20480,
        },
      },
      gemini = {
        endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
        model = "gemini-2.0-flash",
        timeout = 120000, -- Timeout in milliseconds
        context_window = 1048576,
        use_ReAct_prompt = true,
        extra_request_body = {
          generationConfig = {
            temperature = 0.75,
          },
        },
      },
    },
    behaviour = {
      auto_focus_sidebar = true,
      auto_suggestions = false, -- Experimental stage
      auto_suggestions_respect_ignore = false,
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      jump_result_buffer_on_finish = false,
      support_paste_from_clipboard = false,
      minimize_diff = true,
      enable_token_counting = true,
      use_cwd_as_project_root = false,
      auto_focus_on_diff_view = false,
      ---@type boolean | string[] -- true: auto-approve all tools, false: normal prompts, string[]: auto-approve specific tools by name
      auto_approve_tool_permissions = false, -- Default: show permission prompts for all tools
      auto_check_diagnostics = true,
      enable_cursor_planning_mode = true, -- enable cursor planning mode!
    },
    input = {
      provider = "snacks",
      provider_opts = {
        -- Additional snacks.input options
        styles = {
          width = 80,
        },
        width = 80,
        title = "Avante Input",
        icon = " ",
      },
    },
    web_search_engine = {
      provider = "brave",
      proxy = nil,
      providers = {
        brave = {
          api_key_name = "BRAVE_API_KEY", -- default
        },
      },
    },
    -- prefer to use mcphub neovim server
    disabled_tools = {
      "list_files", -- Built-in file operations
      "search_files",
      "read_file",
      "create_file",
      "rename_file",
      "delete_file",
      "create_dir",
      "rename_dir",
      "delete_dir",
      "bash", -- Built-in terminal access
    },
    -- system_prompt as function ensures LLM always has latest MCP server state
    -- This is evaluated for every message, even in existing chats
    system_prompt = function()
      local hub = require("mcphub").get_hub_instance()
      return hub and hub:get_active_servers_prompt() or ""
    end,
    -- Using function prevents requiring mcphub before it's loaded
    custom_tools = function()
      return {
        require("mcphub.extensions.avante").mcp_tool(),
      }
    end,
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "folke/snacks.nvim", -- for input provider snacks
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
    {
      "ravitemer/mcphub.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
      build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
      config = function()
        require("mcphub").setup({
          --- `mcp-hub` binary related options-------------------
          config = vim.fn.expand("~/.config/mcphub/servers.json"), -- Absolute path to MCP Servers config file (will create if not exists)
          port = 37373, -- The port `mcp-hub` server listens to
          shutdown_delay = 60 * 10 * 000, -- Delay in ms before shutting down the server when last instance closes (default: 10 minutes)
          use_bundled_binary = false, -- Use local `mcp-hub` binary (set this to true when using build = "bundled_build.lua")
          mcp_request_timeout = 300000, --Max time allowed for a MCP tool or resource to execute in milliseconds, set longer for long running tasks

          ---Chat-plugin related options-----------------
          auto_approve = false, -- Auto approve mcp tool calls
          auto_toggle_mcp_servers = true, -- Let LLMs start and stop MCP servers automatically
          extensions = {
            avante = {
              make_slash_commands = true, -- make /slash commands from MCP server prompts
            },
          },

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
        })
      end,
    },
  },
}

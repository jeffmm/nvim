return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      -- open dap automatically (auto close was missfiring, use <leader>.u to toggle ui)
      require("dap").listeners.after.event_initialized["dapui_config"] = function()
        require("dapui").open()
      end

      -- highlight groups for nvim dap icons
      -- vim.api.nvim_set_hl(0, "DapBreakpoint", { link = "MoonflyRed" })
      -- vim.api.nvim_set_hl(0, "DapLogPoint", { link = "MoonflyCrimson" })
      -- vim.api.nvim_set_hl(0, "DapStopped", { link = "MoonflyEmerald" })

      local dap = require("dap")
      dap.adapters.godot = {
        type = "server",
        host = "127.0.0.1",
        port = 6006,
      }

      dap.configurations.gdscript = {
        {
          type = "godot",
          request = "launch",
          name = "Launch scene",
          project = "${workspaceFolder}",
          launch_scene = true,
        },
      }
      vim.fn.sign_define("DapBreakpoint", { text = "ඞ", texthl = "DapBreakpoint", numhl = "DapBreakpoint" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DapBreakpoint", numhl = "DapBreakpoint" })
      vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapLogPoint", numhl = "DapLogPoint" })
      vim.fn.sign_define(
        "DapStopped",
        { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" }
      )
    end,
    keys = {
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "toggle breakpoint",
      },
      {
        "<leader>dc",
        function()
          vim.ui.input({ prompt = "Conditional Breakpoint: " }, function(input)
            require("dap").toggle_breakpoint(input)
          end)
        end,
        "conditional breakpoint",
      },
      {
        "<leader>dr",
        function()
          require("dap").continue()
        end,
        desc = "run the debugger, or run the code",
      },
      {
        "<leader>ds",
        function()
          require("dap").step_over()
        end,
        desc = "step over",
      },
      {
        "<leader>dS",
        function()
          require("dap").step_into()
        end,
        desc = "Step into",
      },
    },
  },
  { "theHamsta/nvim-dap-virtual-text", config = true },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
    opts = {
      ensure_installed = { "codelldb" },
      handlers = {},
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    keys = {
      {
        "<leader>du",
        function()
          require("dapui").toggle()
        end,
        desc = "toggle the ui",
      },
    },
    config = function()
      require("dapui").setup({
        mappings = {
          -- Use a table to apply multiple mappings
          expand = { "<CR>", "<2-LeftMouse>" },
          open = "o",
          remove = "d",
          edit = "e",
          repl = "r",
          toggle = "t",
        },
        layouts = {
          {
            elements = {
              "breakpoints",
              "stacks",
              "scopes",
            },
            size = 38, -- 40 columns
            position = "left",
          },
          {
            elements = {
              "repl",
              "watches",
            },
            size = 0.24, -- 24% of total lines
            position = "bottom",
          },
        },
        controls = {
          enabled = true,
          -- Display controls in this element
          element = "repl",
          icons = {
            pause = "",
            play = "",
            step_into = "",
            step_over = "",
            step_out = "",
            step_back = "",
            run_last = "↻",
            terminate = "",
          },
        },
      })
    end,
  },
}

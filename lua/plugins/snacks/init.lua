return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      projects = { enabled = true },
      image = { enabled = true },
      lazygit = { enabled = false },
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      quickfile = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      styles = {
        notification = {
          wo = { wrap = true }, -- Wrap notifications
        },
      },
      scratch = { enabled = false },
    },
    keys = {
      {
        "<leader>n",
        function()
          require("snacks").notifier.show_history()
        end,
        desc = "Notification History",
      },
      {
        "<leader>bd",
        function()
          require("snacks").bufdelete()
        end,
        desc = "Delete Buffer",
      },
      {
        "<leader>cR",
        function()
          require("snacks").rename.rename_file()
        end,
        desc = "Rename File",
      },
      {
        "<leader>gB",
        function()
          require("snacks").gitbrowse()
        end,
        desc = "Git Browse",
        mode = { "n", "v" },
      },
      {
        "<leader>gb",
        function()
          require("snacks").git.blame_line()
        end,
        desc = "Git Blame Line",
      },
      {
        "<leader>gf",
        function()
          require("snacks").lazygit.log_file()
        end,
        desc = "Lazygit Current File History",
      },
      {
        "<leader>gg",
        function()
          require("snacks").lazygit()
        end,
        desc = "Lazygit",
      },
      {
        "<leader>gl",
        function()
          require("snacks").lazygit.log()
        end,
        desc = "Lazygit Log (cwd)",
      },
      {
        "<leader>un",
        function()
          require("snacks").notifier.hide()
        end,
        desc = "Dismiss All Notifications",
      },
      {
        "]]",
        function()
          require("snacks").words.jump(vim.v.count1)
        end,
        desc = "Next Reference",
        mode = { "n", "t" },
      },
      {
        "[[",
        function()
          require("snacks").words.jump(-vim.v.count1)
        end,
        desc = "Prev Reference",
        mode = { "n", "t" },
      },
      {
        "<leader>N",
        desc = "Neovim News",
        function()
          require("snacks").win({
            file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
            width = 0.6,
            height = 0.6,
            wo = {
              spell = false,
              wrap = false,
              signcolumn = "yes",
              statuscolumn = " ",
              conceallevel = 3,
            },
          })
        end,
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            require("snacks").debug.inspect(...)
          end
          _G.bt = function()
            require("snacks").debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Create some toggle mappings
          require("snacks").toggle.option("spell", { name = "Spelling" }):map("<leader>us")
          require("snacks").toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
          require("snacks").toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
          require("snacks").toggle.diagnostics():map("<leader>ud")
          require("snacks").toggle.line_number():map("<leader>ul")
          require("snacks").toggle
            .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
            :map("<leader>uc")
          require("snacks").toggle.treesitter():map("<leader>uT")
          require("snacks").toggle
            .option("background", { off = "light", on = "dark", name = "Dark Background" })
            :map("<leader>ub")
          require("snacks").toggle.inlay_hints():map("<leader>uh")
          require("snacks").toggle.indent():map("<leader>ug")
          require("snacks").toggle.dim():map("<leader>uD")
        end,
      })
    end,
    config = function(_, opts)
      require("snacks").setup(opts)

      -- Register the custom fortune section
      require("snacks").dashboard.sections.fortune = function()
        local fortune_lines = require("plugins.snacks.fortune")({ max_width = 54 })

        -- Join all lines into a single text block with newlines
        local fortune_text = table.concat(fortune_lines, "\n")

        return {
          align = "center",
          text = { fortune_text, hl = "header" },
          padding = 1,
        }
      end
    end,
  },
  require("plugins.snacks.terminal"),
  require("plugins.snacks.picker"),
  require("plugins.snacks.explorer"),
  require("plugins.snacks.zen"),
  require("plugins.snacks.dashboard"),
}

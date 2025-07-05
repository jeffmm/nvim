return {
  { -- Autocompletion
    "saghen/blink.cmp",
    event = "VimEnter",
    dependencies = {
      -- Snippet Engine
      {
        "L3MON4D3/LuaSnip",
        version = "2.*",
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
            return
          end
          return "make install_jsregexp"
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          {
            "rafamadriz/friendly-snippets",
            config = function()
              require("luasnip.loaders.from_vscode").lazy_load()
            end,
          },
        },
        opts = {},
      },
      "folke/lazydev.nvim",
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
          panel = { enabled = false },
          filetypes = {
            markdown = true,
            help = true,
            lua = true,
          },
        },
      },
      "fang2hou/blink-copilot",
      "MeanderingProgrammer/render-markdown.nvim",
      "Kaiser-Yang/blink-cmp-avante",
      -- {
      -- "olimorris/codecompanion.nvim",
      -- lazy = true,
      -- },
    },
    -- use a release tag to download pre-built binaries
    version = "*",
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    -- @module 'blink.cmp'
    -- @type blink.cmp.Config
    keys = {
      -- The keymap preset to use for blink.cmp.
      -- See :h blink-cmp-config-keymap for more information
      -- on the available presets and how to define your own.
      {
        "<leader>lc",
        function()
          if vim.b.completion == nil then
            vim.b.completion = false
          else
            vim.b.completion = not vim.b.completion
          end
        end,
        desc = "[C]ompletion Toggle (buffer)",
      },
      -- The default preset is recommended, as it provides a good balance
      -- of usability and compatibility with other plugins.
      --
    },
    opts = {
      keymap = {

        -- 'default' (recommended) for mappings similar to built-in completions
        --   <c-y> to accept ([y]es) the completion.
        --    This will auto-import if your LSP supports it.
        --    This will expand snippets if the LSP sent a snippet.
        -- 'super-tab' for tab to accept
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- For an understanding of why the 'default' preset is recommended,
        -- you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        --
        -- All presets have the following mappings:
        -- <tab>/<s-tab>: move to right/left of your snippet expansion
        -- <c-space>: Open menu or open docs if already open
        -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
        -- <c-e>: Hide menu
        -- <c-k>: Toggle signature help
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        preset = "enter",
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-e>"] = { "select_and_accept", "fallback" },
        -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
        --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
      },
      appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- Will be removed in a future release
        use_nvim_cmp_as_default = true,
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },
      completion = {
        -- By default, you may press `<c-space>` to show the documentation.
        -- Optionally, set `auto_show = true` to show the documentation after a delay.
        documentation = { auto_show = true, auto_show_delay_ms = 2000 },
        menu = {
          auto_show = true,
        },
        ghost_text = {
          enabled = false,
          show_with_menu = false,
        },
        list = {
          selection = {
            preselect = true,
            auto_insert = true,
          },
        },
      },
      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { "avante", "copilot", "lsp", "path", "snippets", "lazydev", "markdown", "buffer" },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-copilot",
            score_offset = 100,
            async = true,
          },
          markdown = {
            name = "RenderMarkdown",
            module = "render-markdown.integ.blink",
            fallbacks = { "lsp" },
          },
          lazydev = { module = "lazydev.integrations.blink", score_offset = 50 },
          avante = {
            module = "blink-cmp-avante",
            name = "Avante",
            opts = {
              -- options for blink-cmp-avante
            },
          },
        },
        -- per_filetype = {
        -- codecompanion = { "codecompanion" },
        -- },
      },
      snippets = { preset = "luasnip" },

      -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
      -- which automatically downloads a prebuilt binary when enabled.
      --
      -- By default, we use the Lua implementation instead, but you may enable
      -- the rust implementation via `'prefer_rust_with_warning'`
      --
      -- See :h blink-cmp-config-fuzzy for more information
      fuzzy = { implementation = "rust" },

      -- Shows a signature help window while you type arguments for a function
      signature = { enabled = true },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et

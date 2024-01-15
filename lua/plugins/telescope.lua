return {
  "nvim-telescope/telescope.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "debugloop/telescope-undo.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local tele_actions = require("telescope.actions")
    local lga_actions = require("telescope-live-grep-args.actions")
    local lga_shortcuts = require("telescope-live-grep-args.shortcuts")
    local undo_actions = require("telescope-undo.actions")
    local i = require("utils.icons")
    telescope.setup({
      defaults = {
        layout_config = {
          anchor = "center",
          height = 0.8,
          width = 0.9,
          preview_width = 0.6,
          prompt_position = "bottom",
        },
        borderchars = i.telescope,
        mappings = {
          i = {
            ["<esc>"] = tele_actions.close,
          },
        },
      },
      extensions = {
        undo = {
          use_delta = true,
          side_by_side = true,
          entry_format = "󰣜  #$ID, $STAT, $TIME",
          layout_strategy = "flex",
          mappings = {
            i = {
              ["<cr>"] = undo_actions.yank_additions,
              ["§"] = undo_actions.yank_deletions, -- term mapped to shift+enter
              ["<c-\\>"] = undo_actions.restore,
            },
          },
        },
        live_grep_args = {
          auto_quoting = true,
          mappings = {
            i = {
              ["<c-\\>"] = lga_actions.quote_prompt({ postfix = " --hidden " }),
            },
          },
        },
        file_browser = {
          depth = 1,
          auto_depth = false,
          hidden = { file_browser = true, folder_browser = true },
          hide_parent_dir = false,
          collapse_dirs = false,
          prompt_path = false,
          quiet = false,
          dir_icon = "󰉓 ",
          dir_icon_hl = "Default",
          display_stat = { date = true, size = true, mode = true },
          git_status = true,
        },
      },
      keys = {
        { "<leader>u", "<cmd>Telescope undo<cr>", desc = "undo tree" },
        {
          "\\",
          function()
            telescope.extensions.live_grep_args.live_grep_args({
              prompt_title = "grep",
              additional_args = "-i",
            })
          end,
          desc = "live grep",
        },
        { "<leader>o", "<cmd>Telescope oldfiles<cr>", desc = "old files" },
        {
          "<leader>gc",
          function()
            lga_shortcuts.grep_word_under_cursor({ postfix = " --hidden " })
          end,
          desc = "grep under cursor",
        },
        {
          "<leader>f",
          function()
            telescope.extensions.file_browser.file_browser()
          end,
          desc = "browse files",
        },
        {
          "<leader>.",
          function()
            telescope.extensions.file_browser.file_browser({
              path = vim.fn.stdpath("config"),
            })
          end,
          desc = "nvim dotfiles",
        },
      },
    })
    telescope.load_extension("undo")
    telescope.load_extension("file_browser")
    telescope.load_extension("live_grep_args")
  end,
}

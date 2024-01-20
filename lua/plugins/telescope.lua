return {
  "nvim-telescope/telescope.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- "nvim-lua/popup.nvim",
    -- "debugloop/telescope-undo.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim",
    "nvim-telescope/telescope-project.nvim",
    -- "nvim-telescope/telescope-media-files.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local builtin = require("telescope.builtin")
    local tele_actions = require("telescope.actions")
    local lga_actions = require("telescope-live-grep-args.actions")
    local lga_shortcuts = require("telescope-live-grep-args.shortcuts")
    local project_actions = require("telescope._extensions.project.actions")
    -- local undo_actions = require("telescope-undo.actions")
    telescope.setup({
      defaults = {
        layout_config = {
          anchor = "center",
          height = 0.8,
          width = 0.9,
          -- preview_width = 0.6,
          prompt_position = "bottom",
        },
        borderchars = {
          prompt = { "┄", "┊", "┄", "┊", "╭", "╮", "╯", "╰" },
          results = { "┄", " ", "┄", "┊", "╭", "┄", "┄", "╰" },
          preview = { "┄", "┊", "┄", "┊", "┄", "╮", "╯", "╰" },
        },
        mappings = {
          i = {
            ["<esc>"] = tele_actions.close,
          },
        },
      },
      extensions = {
        project = {
          base_dirs = {
            { path = "~/Projects", depth = 1 },
          },
          hidden_files = true, -- default: false
          theme = "dropdown",
          order_by = "asc",
          search_by = "title",
          sync_with_nvim_tree = true, -- default false
          -- on_project_selected = function(prompt_bufnr)
          -- 	-- Do anything you want in here. For example (the default):
          -- 	project_actions.find_project_files(prompt_bufnr, true)
          -- end
        },
        -- media_files = {
        -- 	-- filetypes whitelist
        -- 	-- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
        -- 	filetypes = { "png", "webp", "jpg", "jpeg" },
        -- 	-- find command (defaults to `fd`)
        -- 	find_cmd = "rg",
        -- },
        -- undo = {
        -- 	use_delta = true,
        -- 	side_by_side = true,
        -- 	entry_format = "󰣜  #$ID, $STAT, $TIME",
        -- 	layout_strategy = "flex",
        -- 	mappings = {
        -- 		i = {
        -- 			["<cr>"] = undo_actions.yank_additions,
        -- 			["§"] = undo_actions.yank_deletions, -- term mapped to shift+enter
        -- 			["<c-\\>"] = undo_actions.restore,
        -- 		},
        -- 	},
        -- },
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
    })
    -- vim.keymap.set("n", "<leader>u", ":Telescope undo<cr>", "undo tree")
    vim.keymap.set("n", "\\", function()
      telescope.extensions.live_grep_args.live_grep_args({
        prompt_title = "grep",
        additional_args = "-i",
      })
    end, { desc = "live grep" })
    vim.keymap.set("n", "<leader>o", ":Telescope oldfiles<cr>", { desc = "old files" })
    vim.keymap.set(
      "n",
      "<leader>fp",
      ":lua require'telescope'.extensions.project.project{}<CR>",
      { desc = "find projects" }
    )
    vim.keymap.set("n", "<leader>gc", function()
      lga_shortcuts.grep_word_under_cursor({ postfix = " --hidden " })
    end, { desc = "grep under cursor" })
    vim.keymap.set("n", "<leader>p", ":Telescope find_files<cr>", { desc = "find files" })
    -- vim.keymap.set("n", "<leader>f", function()
    -- 	telescope.extensions.file_browser.file_browser()
    -- end, {desc="browse files"})
    -- vim.keymap.set("n", "<leader>.", function()
    -- 	telescope.extensions.file_browser.file_browser({
    -- 		path = vim.fn.stdpath("config"),
    -- 	})
    -- end, {desc="nvim dotfiles"})
    vim.keymap.set("n", "<leader>.", function()
      builtin.find_files({
        cwd = vim.fn.stdpath("config"),
      })
    end, { desc = "nvim dotfiles" })
    -- telescope.load_extension("undo")
    telescope.load_extension("file_browser")
    telescope.load_extension("live_grep_args")
  end,
}

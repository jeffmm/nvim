return {
  {
    "GCBallesteros/NotebookNavigator.nvim",
    -- keys = {
    -- 	{
    -- 		"]h",
    -- 		function()
    -- 			require("notebook-navigator").move_cell("d")
    -- 		end,
    -- 	},
    -- 	{
    -- 		"[h",
    -- 		function()
    -- 			require("notebook-navigator").move_cell("u")
    -- 		end,
    -- 	},
    -- 	{ "<leader>X", "<cmd>lua require('notebook-navigator').run_cell()<cr>" },
    -- 	{ "<leader>x", "<cmd>lua require('notebook-navigator').run_and_move()<cr>" },
    -- },
    dependencies = {
      "echasnovski/mini.comment",
      -- "hkupty/iron.nvim", -- repl provider
      -- "akinsho/toggleterm.nvim", -- alternative repl provider
      "benlubas/molten-nvim", -- alternative repl provider
      "anuvyklack/hydra.nvim",
    },
    event = "VeryLazy",
    config = function()
      local nn = require("notebook-navigator")
      nn.setup({ activate_hydra_keys = "<leader>h" })
    end,
  },

  {
    "benlubas/molten-nvim",
    dependencies = "3rd/image.nvim",
    build = ":UpdateRemotePlugins",
    ft = { "python", "julia" },
    init = function()
      vim.g.molten_image_provider = "image.nvim"

      -- Output Window
      vim.g.molten_auto_open_output = false
      vim.g.molten_output_win_max_height = 30

      -- Virtual Text
      vim.g.molten_virt_text_output = true
    end,
    config = function()
      local keymap = vim.keymap.set
      keymap("n", "<leader>jo", "<CMD>MoltenEvaluateOperator<CR>", { desc = "Evaluate Operator" })
      keymap("n", "<leader>jl", "<CMD>MoltenEvaluateLine<CR>", { desc = "Evaluate Line" })
      keymap("n", "<leader>jr", "<CMD>MoltenReevaluateCell<CR>", { desc = "Re-evaluate cell" })
      keymap("n", "<leader>jd", "<CMD>MoltenDelete<CR>", { desc = "Delete cell" })
      keymap("n", "<leader>js", "<CMD>MoltenEnterOutput<CR>", { desc = "Show/enter output window" })
      keymap("n", "<leader>jh", "<CMD>MoltenHideOutput<CR>", { desc = "Hide output window" })
      keymap("n", "<leader>jj", "<CMD>MoltenNext<CR>", { desc = "Goto next cell" })
      keymap("n", "<leader>jk", "<CMD>MoltenPrev<CR>", { desc = "Goto prev cell" })
      keymap("v", "X", ":<C-u>MoltenEvaluateVisual<CR>", { desc = "Evaluate visual selection" })
    end,
  },
  {
    "echasnovski/mini.hipatterns",
    event = "VeryLazy",
    dependencies = { "GCBallesteros/NotebookNavigator.nvim" },
    opts = function()
      local nn = require("notebook-navigator")

      local opts = { highlighters = { cells = nn.minihipatterns_spec } }
      return opts
    end,
  },

  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    dependencies = { "GCBallesteros/NotebookNavigator.nvim" },
    opts = function()
      local nn = require("notebook-navigator")

      local opts = { custom_textobjects = { h = nn.miniai_spec } }
      return opts
    end,
  },

  {
    "jeffmm/jupytext.nvim",
    -- Depending on your nvim distro or config you may need to make the loading not lazy
    -- lazy=false,
    opts = {
      jupytext_path = vim.fn.fnamemodify(vim.g.python3_host_prog, ":p:h") .. "/jupytext",
    },
  },
}

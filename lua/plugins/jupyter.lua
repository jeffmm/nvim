return {
  {
    "GCBallesteros/NotebookNavigator.nvim",
    dependencies = {
      "echasnovski/mini.comment",
      -- "hkupty/iron.nvim", -- repl provider
      -- "akinsho/toggleterm.nvim", -- alternative repl provider
      "benlubas/molten-nvim", -- alternative repl provider
      "anuvyklack/hydra.nvim",
    },
    event = "VeryLazy",
    config = function()
      require("hydra.jupyter")
      local nn = require("notebook-navigator")
      nn.setup({ activate_hydra_keys = nil, repl_provider = "molten", syntax_highlight = true })
    end,
  },

  {
    "benlubas/molten-nvim",
    version = "1.7.0",
    enabled = true,
    dependencies = "jeffmm/image.nvim",
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

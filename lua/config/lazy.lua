-- lazy.lua

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	-- bootstrap lazy.nvim
	-- stylua: ignore
	vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
		lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

-- install plugins
require("lazy").setup({
  spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- use alpha.nvim starter
    { import = "lazyvim.plugins.extras.ui.alpha" },
    -- disable auto-pairs
    { "echasnovski/mini.pairs", enabled = false },
    -- load custom plugins
    { import = "plugins" },
  },
  defaults = {
    lazy = false, -- only lazy-load LazyVim plugins by default
    version = false, -- always use the latest git commit
  },
  ui = {
    size = { width = 0.8, height = 0.8 },
    wrap = true,
    border = "shadow",
    icons = {
      cmd = " ",
      config = "",
      event = "",
      ft = " ",
      init = " ",
      import = " ",
      keys = " ",
      lazy = "󰒲 ",
      loaded = "󱄲",
      not_loaded = "󱄯",
      plugin = " ",
      runtime = " ",
      source = " ",
      start = "",
      task = "✔ ",
      list = {
        "󱄰",
        "➜",
        "★",
        "‒",
      },
    },
  },
  install = { colorscheme = { "catppuccin-latte" } },
  checker = { enabled = false }, -- don't automatically check for plugin updates
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true,
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

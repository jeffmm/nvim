-- [[ Plugin installer ]]
--
--  To check the current status of plugins, run :Lazy
--  For info on loading plugins see `:help lazy.nvim-🔌-plugin-spec`
--  (or do `<leader>sh` to search help and search `lazy.nvim-plugin`)

require('lazy').setup {
  spec = {
    { 'tpope/vim-sleuth' }, -- Detect tabstop and shiftwidth automatically
    { import = 'plugins' },
  },
  ui = {
    size = { width = 0.8, height = 0.8 },
    wrap = true,
    border = 'shadow',
    -- If using a nerd font, set icons to an empty table which will use the
    -- default lazy.nvim defined icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = ' ',
      config = '',
      event = '',
      ft = ' ',
      init = ' ',
      import = ' ',
      keys = ' ',
      lazy = '󰒲 ',
      loaded = '󱄲',
      not_loaded = '󱄯',
      plugin = ' ',
      runtime = ' ',
      source = ' ',
      start = '',
      task = '✔ ',
      list = {
        '󱄰',
        '➜',
        '★',
        '‒',
      },
      require = '🌙',
    },
  },
  install = { colorscheme = { 'tokyonight-day' } },
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true,
    rtp = {
      disabled_plugins = {
        'gzip',
        'matchparen',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
}

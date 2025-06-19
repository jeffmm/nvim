return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    dashboard = {
      enabled = true,
      preset = {
        -- stylua: ignore
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "o", desc = "Old Files (deprecated)", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = "󰥨 ", key = "p", desc = "Projects", action = ":lua Snacks.dashboard.pick('projects', {dev = {'~/Projects'}, recent = true, confirm = function(_, item) require('snacks').picker.files({ cwd = item.file }) end})" },
          { icon = "󰄉 ", key = "P", desc = "Profile", action = ":Lazy profile" },
          { icon = " ", key = "s", desc = "Search Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = "󱌣 ", key = "m", desc = "Mason", action = ":Mason" },
          { icon = " ", key = ".", desc = "Config Files", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = "󰭿 ", key = "q", desc = "Quit", action = ":qa" },
          -- { icon = " ", key = "h", desc = "Browse Git", action = ":Flog" },
          -- { icon = " ", key = "g", desc = "Lazygit", action = ":lua require('lazy.util').float_term({ 'lazygit' })" },
          -- { icon = " ", key = ".", desc = "Config Files", action = ":lua Snacks.dashboard.pick('files', {cwd=vim.fn.stdpath('config')})" },
        },
        header = [[
       ▛▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▜
       ▌       ████ ██████           █████      ██                     ▐
       ▌      ███████████             █████                             ▐
       ▌      █████████ ███████████████████ ███   ███████████   ▐
       ▌     █████████  ███    █████████████ █████ ██████████████   ▐
       ▌    █████████ ██████████ █████████ █████ █████ ████ █████   ▐
       ▌  ███████████ ███    ███ █████████ █████ █████ ████ █████  ▐
       ▌ ██████  █████████████████████ ████ █████ █████ ████ ██████ ▐
       ▙▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▟]],
      },
      formats = { header = { "%s", align = "center" } },
      sections = {
        { section = "header" },
        {
          section = "fortune",
          align = "center",
          padding = 0,
        },

        -- {
        -- section for quote text using fortune.lua
        -- },
        { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
        { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        { section = "startup" },
      },
    },
  },
}

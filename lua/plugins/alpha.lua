return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
    local dashboard = require("alpha.themes.dashboard")
    dashboard.section.header.val = {
      "      ████ ██████           █████      ██",
      "     ███████████             █████ ",
      "     █████████ ███████████████████ ███   ███████████",
      "    █████████  ███    █████████████ █████ ██████████████",
      "   █████████ ██████████ █████████ █████ █████ ████ █████",
      " ███████████ ███    ███ █████████ █████ █████ ████ █████",
      "██████  █████████████████████ ████ █████ █████ ████ ██████",
    }

    dashboard.section.buttons.val = {
      dashboard.button("n", "    new file", ":ene<CR>"),
      dashboard.button("o", "    old files", ":Telescope oldfiles<CR>"),
      dashboard.button("f", "󰥨    find file", ":Telescope file_browser<CR>"),
      dashboard.button("g", "󰱼    find text", ":Telescope live_grep_args<CR>"),
      dashboard.button("h", "    browse git", ":lua require('lazy.util').float_term({ 'lazygit' })<CR>"),
      dashboard.button("l", "󰒲    lazy", ":Lazy<CR>"),
      dashboard.button("m", "󱌣    mason", ":Mason<CR>"),
      dashboard.button("p", "󰄉    profile", ":Lazy profile<CR>"),
      dashboard.button("q", "󰭿    quit", ":qa<CR>"),
    }
    local fortune = require("alpha.fortune")
    dashboard.section.footer.val = fortune()
    require("alpha").setup(dashboard.opts)
  end,
}

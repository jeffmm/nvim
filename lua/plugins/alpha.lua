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
      dashboard.button("o", "    old files", ":lua require('snacks').picker.recent()<CR>"),
      dashboard.button("f", "󰥨    find file", ":lua require('snacks').picker.files()<CR>"),
      dashboard.button("t", "󰱼    find text", ":lua require('snacks').picker.grep()<CR>"),
      dashboard.button("p", "󰥨    find projects", ":lua require('snacks').picker.projects()<CR>"),
      -- dashboard.button("h", "    browse git", ":Flog<CR>"),
      -- dashboard.button("g", "    browse git", ":lua require('lazy.util').float_term({ 'lazygit' })<CR>"),
      dashboard.button("l", "󰒲    lazy", ":Lazy<CR>"),
      dashboard.button("m", "󱌣    mason", ":Mason<CR>"),
      dashboard.button("P", "󰄉    profile", ":Lazy profile<CR>"),
      dashboard.button(
        ".",
        "    config",
        ":lua require('snacks').picker.files({cwd = vim.fn.stdpath('config')})<CR>"
      ),

      dashboard.button("q", "󰭿    quit", ":qa<CR>"),
    }
    local fortune = require("alpha.fortune")
    dashboard.section.footer.val = fortune()
    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.hl = "Normal"
      button.opts.hl_shortcut = "Function"
    end
    -- dashboard.section.footer.opts.hl = "Special
    dashboard.opts.layout = {
      { type = "padding", val = 4 },
      dashboard.section.header,
      { type = "padding", val = 4 },
      dashboard.section.buttons,
      { type = "padding", val = 2 },
      dashboard.section.footer,
    }
    require("alpha").setup(dashboard.opts)
  end,
}

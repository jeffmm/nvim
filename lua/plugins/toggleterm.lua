return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    open_mapping = [[<C-\>]],
    direction = "horizontal",
    size = function(term)
      if term.direction == "horizontal" then
        return 20
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.3
      end
    end,
    insert_mappings = true,
    terminal_mappings = true,
    start_in_insert = true,
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
      border = "curved",
      winblend = 10,
    },
  },
  keys = {
    {
      "<leader>t",
      group = "[T]erm",
    },
    {
      "<leader>tt",
      "<cmd>lua ToggleHTerm()<CR>",
      desc = "[T]erminal",
      silent = true,
    },
    {
      "<leader>tT",
      "<cmd>lua ToggleVTerm()<CR>",
      desc = "[T]erminal (vertical)",
      silent = true,
    },
    {
      "<leader>tp",
      "<cmd>lua TogglePyTerm()<CR>",
      desc = "[P]ython",
      silent = true,
    },
    { "<leader>tc", "<cmd>lua ToggleClaudeTerm()<CR>", desc = "[C]laude", silent = true, mode = "n" },
    {
      "<leader>to",
      "<cmd>lua ToggleTopTerm()<CR>",
      desc = "T[o]p",
      silent = true,
    },
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)

    -- Terminal keymaps for better navigation
    function _G.set_terminal_keymaps()
      local t_opts = { buffer = 0 }
      vim.keymap.set("t", "<esc><esc>", [[<C-\><C-n>]], t_opts)
      vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], t_opts)
    end
    local python_cmd = vim.fn.executable("ipython") == 1 and "ipython" or "python"
    local top_cmd = vim.fn.executable("htop") == 1 and "htop" or "top"
    local Terminal = require("toggleterm.terminal").Terminal
    local my_hterm = Terminal:new({
      direction = "horizontal",
      count = 5,
    })
    local my_vterm = Terminal:new({
      direction = "vertical",
      count = 15,
    })
    local claude_term = Terminal:new({
      cmd = "claude",
      dir = "git_dir",
      direction = "vertical",
      count = 25,
    })
    local ipython_term = Terminal:new({
      cmd = python_cmd,
      direction = "vertical",
      count = 35,
    })
    local top_term = Terminal:new({
      cmd = top_cmd,
      direction = "float",
      count = 35,
    })

    function _G.ToggleVTerm()
      my_vterm:toggle()
    end
    function _G.ToggleHTerm()
      my_hterm:toggle()
    end
    function _G.ToggleClaudeTerm()
      claude_term:toggle()
    end
    function _G.TogglePyTerm()
      ipython_term:toggle()
    end
    function _G.ToggleTopTerm()
      top_term:toggle()
    end

    -- vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })
    -- Apply keymaps to all terminals
    vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
  end,
}

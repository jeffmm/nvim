return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    terminal = { enabled = true },
  },
  keys = {
    {
      "<leader>t",
      group = "[T]erm",
    },
    {
      "<leader>tt",
      function()
        require("snacks").terminal()
      end,
      desc = "[T]erminal",
      silent = true,
    },
    {
      "<leader>tT",
      function()
        require("snacks").terminal(nil, { win = { position = "right" } })
      end,
      desc = "[T]erminal (vertical)",
      silent = true,
    },
    {
      "<leader>tp",
      function()
        -- check if ipython is available from the current virtual environment
        -- if not, then fallback to python
        if vim.fn.executable("ipython") == 1 then
          require("snacks").terminal("ipython")
          return
        else
          require("snacks").terminal("python")
          return
        end
      end,
      desc = "[P]ython",
      silent = true,
    },
    {
      "<leader>to",
      function()
        require("snacks").terminal("top")
      end,
      desc = "T[O]p",
      silent = true,
    },
  },
}

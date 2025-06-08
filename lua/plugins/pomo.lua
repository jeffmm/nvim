return {
  "epwalsh/pomo.nvim",
  version = "*", -- Recommended, use latest release instead of latest commit
  lazy = true,
  cmd = { "TimerStart", "TimerRepeat", "TimerSession" },
  dependencies = {
    -- Optional, but highly recommended if you want to use the "Default" timer
    "rcarriga/nvim-notify",
  },
  opts = {
    sessions = {
      pomodoro = {
        { name = "Work", duration = "25m" },
        { name = "Short Break", duration = "5m" },
        { name = "Work", duration = "25m" },
        { name = "Short Break", duration = "5m" },
        { name = "Work", duration = "25m" },
        { name = "Long Break", duration = "15m" },
      },
    },
  },
  keys = {
    {
      "<leader>pm",
      function()
        require("telescope").extensions.pomodori.timers()
      end,
      desc = "Manage Timers",
    },
    {
      "<leader>pn",
      function()
        vim.ui.input({ prompt = "Duration: " }, function(input)
          vim.cmd("TimerStart " .. input .. "m timer")
        end)
      end,
      desc = "New Timer",
    },
    { "<leader>pv", "<cmd>TimerShow<cr>", desc = "View Timer" },
    { "<leader>ph", "<cmd>TimerHide<cr>", desc = "Hide Timer" },
    { "<leader>ps", "<cmd>TimerStop<cr>", desc = "Stop Timer" },
    { "<leader>pp", "<cmd>TimerPause<cr>", desc = "Pause Timer" },
    { "<leader>pr", "<cmd>TimerResume<cr>", desc = "Resume Timer" },
  },
}

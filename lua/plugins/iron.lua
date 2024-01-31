return {
  "hkupty/iron.nvim",
  enabled = true,
  config = function()
    local iron = require("iron.core")
    iron.setup({
      config = {
        scratch_repl = true,
        repl_definition = {
          python = {
            command = { "ipython" },
            format = require("iron.fts.common").bracketed_paste,
          },
        },
        repl_open_cmd = "vertical botright 80 split",
      },
      keymaps = {
        send_motion = "<leader>r",
        visual_send = "<leader>r",
      },
    })
  end,
}

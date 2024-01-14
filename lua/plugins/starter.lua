return {
  {
    {
      "echasnovski/mini.starter",
      enable = false,
      version = "*",
      config = function()
        local starter = require("mini.starter")

        starter.setup({
          -- perform action when there's only one matching item
          evaluate_single = false,

          items = {
            starter.sections.recent_files(8, true), -- current directory
          },

          -- Header to be displayed before items. Converted to single string via
          -- `tostring` (use `\n` to display several lines). If function, it is
          -- evaluated first. If `nil` (default), polite greeting will be used.
          header = [[
                                             
      ████ ██████           █████      ██
     ███████████             █████ 
     █████████ ███████████████████ ███   ███████████
    █████████  ███    █████████████ █████ ██████████████
   █████████ ██████████ █████████ █████ █████ ████ █████
 ███████████ ███    ███ █████████ █████ █████ ████ █████
██████  █████████████████████ ████ █████ █████ ████ ██████]],

          footer = nil,

          -- Array  of functions to be applied consecutively to initial content.
          -- Each function should take and return content for 'Starter' buffer (see
          -- |mini.starter| and |MiniStarter.content| for more details).
          content_hooks = {
            starter.gen_hook.adding_bullet("> "),
            starter.gen_hook.aligning("center", "center"),
          },

          -- this is default - the "-" so I can get to oil
          query_updaters = "abcdefghijklmnopqrstuvwxyz0123456789_.",
        })
      end,
    },
  },
}

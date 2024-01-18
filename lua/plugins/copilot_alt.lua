return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
	build = ":Copilot auth",
  event = "InsertEnter",
  enabled = true,
  opts = {
    suggestion = {
      enabled = true,
      auto_trigger = true,
      debounce = 75,
      keymap = {
        accept = "<M-l>",
        accept_word = false,
        accept_line = false,
        next = "<M-j>",
        prev = "<M-k>",
        dismiss = "<M-h>",
      },
    },
    filetypes = {
      norg = false,
      quarto = false, -- it get's very confused
    },
    config = true,
  },
}

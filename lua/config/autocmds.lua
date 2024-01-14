local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local keymap = vim.keymap.set

local defaults = augroup("Defaults", {})

autocmd("FileType", {
  desc = "Disable newline comments when inserting lines with o/O",
  group = defaults,
  pattern = { "*" },
  callback = function()
    vim.opt_local.formatoptions:remove("o")
  end,
})

autocmd("Termopen", {
  desc = "Unclutter terminal",
  group = defaults,
  pattern = { "*" },
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.scrolloff = 0
  end,
})

autocmd("FileType", {
  desc = "Enable spellchecker",
  group = defaults,
  pattern = { "gitcommit", "tex", "NeogitCommitMessage" },
  callback = function()
    vim.opt_local.spell = true
  end,
})

autocmd("FileType", {
  desc = "Disable foldcolumn",
  group = defaults,
  pattern = {
    "neotest-summary",
    "dap-repl",
    "NeogitCommitMessage",
    "NeogitCommitView",
    "NeogitPopup",
    "NeogitStatus",
  },
  callback = function()
    vim.opt_local.foldcolumn = "0"
  end,
})

autocmd("LspAttach", {
  desc = "LSP",
  group = augroup("lsp", { clear = false }),
  callback = function(ev)
    local lsp = vim.lsp

    -- Mappings
    keymap({ "n", "i" }, "<C-h>", lsp.buf.signature_help, { buffer = ev.buf })

    keymap("n", "<A-h>", function()
      lsp.inlay_hint.enable(nil, not lsp.inlay_hint.is_enabled(0))
    end, { buffer = ev.buf, desc = "Toggle Hints" })

    keymap({ "n", "v" }, "<leader>la", lsp.buf.code_action, { buffer = ev.buf, desc = "LSP Actions" })
    keymap("n", "<leader>lr", lsp.buf.rename, { buffer = ev.buf, desc = "LSP Rename" })
    keymap("n", "<leader>ll", lsp.codelens.run, { buffer = ev.buf, desc = "LSP Lens" })

    -- NOTE we define this mapping here, instead of using "<leader>f" because it overrides nvim's default gd
    -- (which is a primitive way of going to definition), in spite of it being a Telescope mapping
    keymap("n", "gd", "<CMD>Telescope lsp_definitions<CR>", { buffer = ev.buf, desc = "Go to Definition" })
  end,
})

autocmd("TextYankPost", {
  desc = "Highlight on yank",
  group = augroup("highlight_yank", {}),
  callback = function()
    vim.highlight.on_yank()
  end,
})

return {
  "stevearc/conform.nvim",
  event = { "LspAttach", "BufWritePre" },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      sh = { "shfmt" },
      gdscript = { "gdformat" },
      markdown = { "injected", "markdownlint" },
      yaml = { "prettier" },
      typescript = { "prettier" },
    },
  },
}

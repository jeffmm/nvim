return {
  "jay-babu/mason-nvim-dap.nvim",
  dependencies = { "williamboman/mason.nvim" },
  cmd = "Mason",
  opts = {
    ensure_installed = {
      "bash",
      "cppdbg",
      "js",
      "php",
      "python",
    },
    auto_update = false,
    run_on_start = false,
    automatic_setup = true,
  },
}

return {
  "mason-org/mason.nvim",
  build = ":MasonInstallAll",
  opts = function()
    local ui = {
      border = "shadow",
      icons = {
        package_installed = "󱄲",
        package_pending = "󱄰",
        package_uninstalled = "󱄯",
      },
      zindex = 99,
    }
    vim.api.nvim_create_user_command("MasonInstallAll", function()
      vim.cmd("MasonUpdate")
      local ensure_installed = {
        "bash-language-server",
        "black",
        "clang-format",
        "css-lsp",
        "dockerfile-language-server",
        "eslint-lsp",
        "gdtoolkit",
        "html-lsp",
        "json-lsp",
        "lua-language-server",
        "php-cs-fixer",
        "prettierd",
        "pyright",
        "ruff",
        "rust-analyzer",
        "shellcheck",
        "shellharden",
        "shfmt",
        "stylua",
        "sqlfluff",
        "tailwindcss-language-server",
        "terraform-ls",
        "tflint",
        "typescript-language-server",
        "yaml-language-server",
      }
      vim.cmd("MasonInstall " .. table.concat(ensure_installed, " "))
    end, { desc = "Install all LSP tools" })
    return ui
  end,
}

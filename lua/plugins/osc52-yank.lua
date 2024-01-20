return {
  "ojroques/vim-oscyank",
  enabled = true,
  event = "VeryLazy",
  dependencies = {
    "ojroques/nvim-osc52",
  },
  config = function()
    vim.api.nvim_set_option("clipboard", "unnamedplus")
    vim.api.nvim_create_autocmd("TextYankPost", {
      group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
      callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 500 })
        if vim.v.event.operator == "y" and vim.v.event.regname == "" then
          vim.cmd([[OSCYankRegister]])
        end
      end,
    })
    local function copy(lines, _)
      require("osc52").copy(table.concat(lines, "\n"))
    end

    local function paste()
      return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
    end

    vim.g.clipboard = {
      name = "osc52",
      copy = { ["+"] = copy, ["*"] = copy },
      paste = { ["+"] = paste, ["*"] = paste },
    }
  end,
}

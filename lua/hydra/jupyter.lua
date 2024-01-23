local Hydra = require("hydra")
local nn = require("notebook-navigator")
local hydra_hint = [[
 _j_/_k_: move ↓/↑    _J_/_K_: swap ↓/↑    _O_/_o_: new ↓/↑
  _c_: comment   _X_/_x_: run/run & move ↓    _i_: inspect
              _D_: delete     _<esc>_/_q_: exit
]]
Hydra({
  name = "Notebook",
  hint = hydra_hint,
  config = {
    color = "pink",
    invoke_on_body = true,
    hint = { border = "rounded" },
  },
  mode = { "n" },
  body = "<leader>j",
  heads = {
    {
      "j",
      function()
        nn.move_cell("d")
      end,
      { desc = "↓" },
    },
    {
      "k",
      function()
        nn.move_cell("u")
      end,
      { desc = "↑" },
    },
    {
      "J",
      function()
        nn.swap_cell("d")
      end,
      { desc = "swap ↓" },
    },
    {
      "K",
      function()
        nn.swap_cell("u")
      end,
      { desc = "swap ↑" },
    },

    {
      "o",
      nn.add_cell_below,
      { desc = "new ↓", exit = true },
    },
    {
      "O",
      nn.add_cell_above,
      { desc = "new ↑", exit = true },
    },
    {
      "c",
      nn.comment,
      { desc = "comment" },
    },
    {
      "X",
      nn.run_cell,
      { desc = "run" },
    },
    {
      "x",
      nn.run_and_move,
      { desc = "run & move" },
    },
    {
      "D",
      function()
        local cell_bounds = nn.miniai_spec("a")
        if vim.fn.setpos(".", { 0, cell_bounds.from.line, cell_bounds.from.col, 0 }) == 0 then
          vim.cmd("normal! d" .. cell_bounds.to.line - cell_bounds.from.line)
        end
      end,
      { desc = "delete" },
    },
    { "i", ":noautocmd MoltenEnterOutput<CR>", { desc = "enter output" } },
    { "h", ":MoltenHideOutput<CR>", { desc = "hide" } },
    { "H", ":MoltenShowOutput<CR>", { desc = "show" } },
    { "<esc>", nil, { exit = true, desc = false } },
    { "q", nil, { exit = true, desc = false } },
  },
})

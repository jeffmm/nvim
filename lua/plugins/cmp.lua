return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lua",
    -- "windwp/nvim-autopairs",
    "onsails/lspkind-nvim",
    -- { "roobert/tailwindcss-colorizer-cmp.nvim", config = true }
  },
  config = function()
    local cmp = require("cmp")
    local cmp_next = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif require("luasnip").expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
      else
        fallback()
      end
    end
    local cmp_prev = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif require("luasnip").jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
      else
        fallback()
      end
    end

    ---@diagnostic disable-next-line
    cmp.setup({
      enabled = true,
      preselect = cmp.PreselectMode.None,
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          local kind = require("lspkind").cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            symbol_map = { Copilot = "󰚩" },
          })(entry, vim_item)
          local strings = vim.split(kind.kind, "%s", { trimempty = true })
          kind.kind = " " .. (strings[1] or "") .. " "
          kind.menu = "    (" .. (strings[2] or "") .. ")"
          return kind
        end,
      },
      window = {
        documentation = cmp.config.window.bordered({
          winhighlight = "Normal:Normal,FloatBorder:LspBorderBG,CursorLine:PmenuSel,Search:None",
          zindex = 9999,
          winblend = 10,
        }),
        completion = cmp.config.window.bordered({
          winhighlight = "Normal:Normal,FloatBorder:LspBorderBG,CursorLine:PmenuSel,Search:None",
          col_offset = -3,
          side_padding = 0,
          zindex = 1001,
          winblend = 30,
        }),
      },
      ---@diagnostic disable-next-line
      view = {
        entries = { name = "custom", selection_order = "near_cursor", bordered = true },
      },
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      mapping = {
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<S-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        }),
        ["<tab>"] = cmp_next,
        ["<down>"] = cmp_next,
        ["<S-tab>"] = cmp_prev,
        ["<up>"] = cmp_prev,
      },
      sources = {
        { name = "path", group_index = 1 },
        { name = "nvim_lsp_signature_help", group_index = 1 },
        { name = "luasnip", max_item_count = 5, group_index = 1 },
        { name = "nvim_lsp", max_item_count = 20, group_index = 1 },
        { name = "nvim_lua", group_index = 1 },
        { name = "buffer", keyword_length = 2, max_item_count = 5, group_index = 1 },
        { name = "copilot", max_item_count = 3, group_index = 2 },
      },
    })
    local presentAutopairs, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
    if not presentAutopairs then
      return
    end
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
  end,
}

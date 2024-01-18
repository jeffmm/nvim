return {
  "smjonas/inc-rename.nvim",
	enabled=false,
	lazy = true,
	cmd = {
		"IncRename",
	},
  config = function()
    require("inc_rename").setup()
  end,
}

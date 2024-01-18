return {
	"kylechui/nvim-surround",
	version = "*",
	event = "VeryLazy",
	config = function()
		---@diagnostic disable-next-line
		require("nvim-surround").setup({
			keymaps = {
				insert = false,
				insert_line = false,
				normal = false,
				normal_cur = false,
				normal_line = false,
				normal_cur_line = false,
				visual = "S",
				visual_line = false,
				delete = false,
				change = false,
				change_line = false,
			},
		})
	end,
}

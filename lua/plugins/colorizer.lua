return {
	"brenoprata10/nvim-highlight-colors",
	event = "VeryLazy",
	config = function()
		local c = require("nvim-highlight-colors")
		c.setup({})
		vim.api.nvim_create_user_command("ColorizerToggle", function()
			c.toggle()
		end, {desc="toggle colorizer"})
	end,
}

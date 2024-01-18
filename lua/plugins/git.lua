return {
	"sindrets/diffview.nvim", -- optional - Diff integration
	config = function()
		vim.keymap.set("n", "<leader>gd", function()
			local lib = require("diffview.lib")
			local view = lib.get_current_view()
			if view then
				-- Current tabpage is a Diffview; close it
				vim.cmd.DiffviewClose()
			else
				-- No open Diffview exists: open a new one
				vim.cmd.DiffviewOpen()
			end
		end, {desc="diffview"})
		require("diffview").setup({})
	end,
}

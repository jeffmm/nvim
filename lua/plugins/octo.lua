return {
  "pwntester/octo.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-tree/nvim-web-devicons",
  },
	opts = {
	  mappings = {
			review_diff = {
				add_review_comment = { lhs = "<leader>i", desc = "add a new review comment" },
			}
		}
	}
}

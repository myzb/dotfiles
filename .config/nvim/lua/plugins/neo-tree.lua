return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	keys = {
		{ "<leader>e", "<cmd>Neotree toggle<cr>", desc = "File explorer" },
	},
	opts = {
		filesystem = {
			filtered_items = {
				visible = false,
			},
		},
	},
	config = function(_, opts)
		require("neo-tree").setup(opts)
	end,
}

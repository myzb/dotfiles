return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	keys = {
		{ "<C-e>", "<cmd>Neotree toggle<cr>", desc = "File explorer" },
	},
	opts = {
		filesystem = {
			filtered_items = {
				visible = true,
			},
		},
	},
	config = function(_, opts)
		require("neo-tree").setup(opts)
	end,
}

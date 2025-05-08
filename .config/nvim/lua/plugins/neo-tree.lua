return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	enabled = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	keys = {
		{ "<Leader>e", "<Cmd>Neotree toggle<CR>", desc = "File explorer" },
	},
	opts = {
		filesystem = {
			filtered_items = {
				visible = false,
			},
		},
	},
}

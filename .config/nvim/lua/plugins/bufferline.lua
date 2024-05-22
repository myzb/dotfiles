return {
	"akinsho/bufferline.nvim",
	version = "*",
	enabled = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	event = "ColorScheme",
	opts = {
		options = {
			separator_style = "thin",
			offsets = {
				{
					filetype = "neo-tree",
				},
			},
		},
	},
	config = function(_, opts)
		require("bufferline").setup(opts)
	end,
}

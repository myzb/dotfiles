return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = true,
	opts = {
		dim_inactive = {
			enabled = false,
		},
		integrations = {
			neotree = true,
			native_lsp = {
				enabled = true,
			},
			indent_blankline = {
				enabled = true,
			},
			which_key = true,
		},
		custom_highlights = function(color)
			return {}
		end,
	},
	config = function(_, opts)
		require("catppuccin").setup(opts)
	end,
}

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
				-- 	virtual_text = {
				-- 		errors = { "italic" },
				-- 		hints = { "italic" },
				-- 		warnings = { "italic" },
				-- 		information = { "italic" },
				-- 	},
				-- 	underlines = {
				-- 		errors = { "underline" },
				-- 		hints = { "underline" },
				-- 		warnings = { "underline" },
				-- 		information = { "underline" },
				-- 	},
				-- 	inlay_hints = {
				-- 		background = true,
				-- 	},
			},
			indent_blankline = {
				enabled = true,
				-- scope_color = "", -- catppuccin color (eg. `lavender`) Default: text
				-- colored_indent_levels = false,
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

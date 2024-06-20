return {
	"gbprod/nord.nvim",
	lazy = true,
	opts = {
		on_highlights = function(hl, c)
			hl["TelescopePromptBorder"] = { link = "Label" }
		end,
	},
	config = function(_, opts)
		require("nord").setup(opts)
	end,
}

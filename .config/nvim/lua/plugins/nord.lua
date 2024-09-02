return {
	"gbprod/nord.nvim",
	lazy = true,
	opts = {
		on_highlights = function(hl, c)
			-- Popups without borders
			hl["WhichKeyNormal"] = { link = "Pmenu" }
			hl["NormalFloat"] = { link = "Pmenu" }
			hl["FloatBorder"] = { link = "Pmenu" }

			-- Popups with borders
			hl["NeoTreeFloatNormal"] = { link = "TelescopeBorder" }
			hl["NeoTreeFloatBorder"] = { link = "TelescopeBorder" }
		end,
	},
	config = function(_, opts)
		require("nord").setup(opts)
	end,
}

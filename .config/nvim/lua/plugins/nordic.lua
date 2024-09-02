return {
	"AlexvZyl/nordic.nvim",
	branch = "dev",
	config = function(_, opts)
		local palette = require("nordic.colors")
		require("nordic").setup({
			telescope = {
				style = "classic",
			},
			override = {
				-- Variant 1
				-- FloatBorder = { bg = palette.bg, fg = palette.white0 },
				-- NormalFloat = { bg = palette.bg, fg = palette.white0 },

				-- Variant 2
				FloatBorder = { bg = palette.black1, fg = palette.white0 },
				WhichKeyNormal = { bg = palette.black1, fg = palette.white_alt },
			},
		})
	end,
}

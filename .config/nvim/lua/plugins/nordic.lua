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
				-- Popups without borders
				NormalFloat = { link = "Pmenu" },
				FloatBorder = { link = "Pmenu" },
				WhichKeyNormal = { link = "Pmenu" },

				-- Popups with borders
				NeoTreeFloatNormal = { link = "TelescopeBorder" },
				NeoTreeFloatBorder = { link = "TelescopeBorder" },
			},
		})
	end,
}

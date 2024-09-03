return {
	"AlexvZyl/nordic.nvim",
	branch = "dev",
	lazy = true,
	config = function(_, opts)
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

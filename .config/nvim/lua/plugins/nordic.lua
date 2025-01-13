return {
	"AlexvZyl/nordic.nvim",
	lazy = true,
	opts = {
		on_highlight = function(hl, c)
			-- Popups without borders
			hl["NormalFloat"] = { link = "Pmenu" }
			hl["FloatBorder"] = { link = "Pmenu" }
			hl["WhichKeyNormal"] = { link = "Pmenu" }

			-- Popups with borders
			hl["NeoTreeFloatNormal"] = { link = "FzfLuaNormal" }
			hl["NeoTreeFloatBorder"] = { link = "FzfLuaBorder" }

			-- Popup menu, item kind icon_text
			hl["PmenuKind"] = { fg = c.magenta.base, bg = c.black1 }
		end,
	},
	config = function(_, opts)
		require("nordic").setup(opts)
	end,
}

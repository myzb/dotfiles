return {
	"gbprod/nord.nvim",
	lazy = true,
	opts = {
		on_highlights = function(hl, c)
			-- Popups without borders
			hl["NormalFloat"] = { link = "Pmenu" }
			hl["FloatBorder"] = { link = "Pmenu" }
			hl["FloatTitle"] = { link = "Pmenu" }
			hl["WhichKeyNormal"] = { link = "Pmenu" }

			-- Popups with borders
			hl["NeoTreeFloatNormal"] = { link = "FzfLuaBorder" }
			hl["NeoTreeFloatBorder"] = { link = "FzfLuaBorder" }

			-- hl["SnacksPicker"] = { link = "BufferInactive" }
			-- hl["SnacksPickerBorder"] = { link = "BufferInactive" }
			hl["SnacksPickerPathHidden"] = { link = "@text.phpdoc" }
			hl["SnacksPickerPathIgnore"] = { link = "@text.phpdoc" }
			hl["SnacksPickerFile"] = { link = "@text" }

			-- Popup menu, item kind icon_text
			hl["PmenuKind"] = { fg = c.aurora.purple, bg = c.polar_night.bright }
		end,
	},
	config = function(_, opts)
		require("nord").setup(opts)
	end,
}

return {
	"gbprod/nord.nvim",
	lazy = true,
	opts = {
		on_highlights = function(hl, c)
			-- Popups without borders
			hl["NormalFloat"] = { link = "Pmenu" }
			hl["FloatBorder"] = { link = "Pmenu" }
			-- hl["FloatTitle"] = { link = "Pmenu" }
			hl["WhichKeyNormal"] = { link = "Pmenu" }

			-- Popups with borders
			hl["NeoTreeFloatNormal"] = { link = "FzfLuaBorder" }
			hl["NeoTreeFloatBorder"] = { link = "FzfLuaBorder" }

			-- Snacks Picker
			hl["SnacksPickerBorder"] = { fg = c.frost.ice, bg = c.polar_night.bright }
			hl["SnacksPickerBoxBorder"] = { fg = c.snow_storm.origin, bg = c.polar_night.bright }
			hl["SnacksPickerListBorder"] = { fg = c.snow_storm.origin, bg = c.polar_night.bright }
			hl["SnacksPickerPreviewBorder"] = { fg = c.snow_storm.origin, bg = c.polar_night.bright }

			-- Snacks Scratch
			-- hl["SnacksScratchTitle"] = { link = "Normal" }
			-- hl["SnacksScratchFooter"] = { link = "Normal" }
			-- hl["SnacksScratchDesc"] = { link = "Normal" }
			-- hl["SnacksScratchKey"] = { link = "Normal" }

			-- Snacks explorer texts (fixup)
			hl["SnacksPickerPathHidden"] = { link = "@text.phpdoc" }
			hl["SnacksPickerPathIgnore"] = { link = "@text.phpdoc" }
			hl["SnacksPickerIconFile"] = { link = "@text" }
			hl["SnacksIndentScope"] = { fg = "#4C566A" }

			-- Popup menu, item kind icon_text
			hl["PmenuKind"] = { fg = c.aurora.purple, bg = c.polar_night.bright }
		end,
	},
	config = function(_, opts)
		require("nord").setup(opts)
	end,
}

return {
	"gbprod/nord.nvim",
	lazy = true,
	opts = {
		on_highlights = function(hl, c)
			-- Popups without borders
			hl["NormalFloat"] = { link = "Pmenu" }
			hl["FloatBorder"] = { link = "Pmenu" }
			hl["WhichKeyNormal"] = { link = "Pmenu" }

			-- Popups with borders
			hl["NeoTreeFloatNormal"] = { fg = c.polar_night.light, bg = c.polar_night.origin }
			hl["NeoTreeFloatBorder"] = { fg = c.polar_night.light, bg = c.polar_night.origin }
			hl["NeoTreeRootName"] = { fg = c.frost.artic_water, bold = true }

			-- Popup menu, item kind icon_text
			hl["PmenuKind"] = { fg = c.aurora.purple, bg = c.polar_night.bright }
		end,
	},
}

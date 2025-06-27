return {
	"gbprod/nord.nvim",
	lazy = false, -- don't lazy load main themes
	priority = 1000,
	opts = {
		on_colors = function(c)
			c.polar_night.dark = "#2a2e3b" -- new color, darker than .origin
		end,
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
	config = function(_, opts)
		require("nord").setup(opts)
		vim.cmd([[colorscheme nord]])
	end,
}

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

			-- Snacks
			hl["SnacksIndentScope"] = { fg = "#4C566A" }

			-- Snacks (picker window)
			hl["SnacksPicker"] = { fg = c.snow_storm.origin }
			hl["SnacksPickerBorder"] = { fg = c.frost.polar_water }
			hl["SnacksPickerBoxBorder"] = { fg = c.polar_night.light }
			hl["SnacksPickerPreviewBorder"] = { fg = c.polar_night.light }

			-- Snacks (picker text)
			hl["SnacksPickerPathHidden"] = { link = "@text.phpdoc" }
			hl["SnacksPickerPathIgnore"] = { link = "@text.phpdoc" }
			hl["SnacksPickerPathIgnored"] = { link = "@text.phpdoc" }
			-- hl["SnacksPickerPathUnselected"] = { link = "@text.phpdoc" }
			-- hl["SnacksPickerGitStatusIgnored"] = { link = "@text.phpdoc" }
			hl["SnacksPickerGitStatusUntracked"] = { link = "@text.phpdoc" }

			-- Picker (prompt)
			hl["SnacksPickerTotals"] = { fg = c.aurora.green }
			hl["SnacksPickerPrompt"] = { fg = c.frost.ice, bold = true }
			hl["SnacksPickerMatch"] = { fg = c.frost.ice, bold = true }

			-- Snacks Scratch (match picker)
			hl["SnacksScratchDesc"] = { fg = c.frost.ice, bg = c.polar_night.bright }
			hl["SnacksScratchKey"] = { fg = c.polar_night.bright, bg = c.frost.ice }

			-- Popup menu, item kind icon_text
			hl["PmenuKind"] = { fg = c.aurora.purple, bg = c.polar_night.bright }
		end,
	},
}

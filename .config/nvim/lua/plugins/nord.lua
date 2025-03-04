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

			-- Snacks
			-- hl["SnacksPicker"] = { link = "BufferInactive" }
			-- hl["SnacksPickerBorder"] = { link = "Pmenu" }
			-- hl["SnacksPickerBoxBorder"] = { link = "BufferInactive" }
			-- hl["SnacksPickerListBorder"] = { link = "BufferInactive" }
			-- hl["SnacksPickerPreviewBorder"] = { link = "BufferInactive" }
			-- hl["SnacksPickerPreviewBorder"] = { link = "BufferInactive" }

			-- hl["SnacksScratchTitle"] = { link = "Normal" }
			-- hl["SnacksScratchFooter"] = { link = "Normal" }
			-- hl["SnacksScratchDesc"] = { link = "Normal" }
			-- hl["SnacksScratchKey"] = { link = "Normal" }

			-- Fix some texts
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

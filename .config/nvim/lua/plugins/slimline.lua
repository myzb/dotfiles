return {
	"sschleemilch/slimline.nvim",
	init = function()
		vim.opt.laststatus = 3 -- have a single global statusline
		vim.opt.cmdheight = 0 -- autoshow cmdline only when needed
	end,
	opts = {
		style = "fg",
		bold = true,
		hl = {
			secondary = "Comment",
		},
		spaces = {
			left = "",
			right = "",
		},
		sep = {
			hide = {
				first = true,
				last = true,
			},
			left = "",
			right = "",
		},
		components = {
			right = {
				"recording",
				"diagnostics",
				"filetype_lsp",
				"progress",
			},
		},
		configs = {
			mode = {
				verbose = true,
				style = "bg",
				hl = {
					normal = "Label",
					insert = "Normal",
					pending = "Function",
					visual = "Function",
					command = "String",
				},
			},
			path = {
				hl = {
					primary = "Label",
				},
			},
			git = {
				hl = {
					primary = "Function",
				},
			},
			filetype_lsp = {
				hl = {
					primary = "String",
				},
			},
			recording = {
				hl = {
					primary = "DiagnosticError",
				},
			},
			progress = {
				style = "bg",
			},
		},
	},
}

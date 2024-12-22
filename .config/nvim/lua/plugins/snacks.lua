return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	enabled = false,
	opts = {
		bigfile = { enabled = true },
		dashboard = { enabled = false },
		indent = {
			enabled = true,
			animate = { enabled = false },
			scope = {
				hl = "SnacksIndent2",
			},
		},
		input = { enabled = false },
		notifier = { enabled = false },
		quickfile = { enabled = true },
		scroll = { enabled = false },
		statuscolumn = { enabled = false },
		words = { enabled = true },
	},
}

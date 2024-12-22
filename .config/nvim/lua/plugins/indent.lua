return {
	{
		-- Indentation line
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		enabled = false,
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			whitespace = { remove_blankline_trail = true },
			exclude = {
				filetypes = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
			},
			indent = { char = "▎", tab_char = "▎" },
		},
		config = function(_, opts)
			require("ibl").setup(opts)
		end,
	},
	{
		-- Autodetect indent width/type
		"tpope/vim-sleuth",
	},
}

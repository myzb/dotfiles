return {
	{
		"rcarriga/nvim-notify",
		lazy = true,
		opts = {
			stages = "fade",
		},
	},
	{
		"m4xshen/hardtime.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		keys = {
			{
				"<Leader>H",
				function()
					require("hardtime").toggle()
				end,
				desc = "Hardtime",
			},
		},
		opts = {
			enabled = true,
			restriction_mode = "hint",
			disable_mouse = false,
			disabled_keys = {
				["<Up>"] = false,
				["<Down>"] = false,
				["<Left>"] = false,
				["<Right>"] = false,
			},
			callback = function(text)
				require("notify")(text, vim.log.levels.WARN, { title = "Hardtime", timeout = 3000 })
			end,
		},
		config = function(_, opts)
			require("hardtime").setup(opts)
		end,
	},
}

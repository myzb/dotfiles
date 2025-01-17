return {
	-- Bottom statusline
	"nvim-lualine/lualine.nvim",
	event = "ColorScheme",
	init = function()
		vim.opt.showmode = false -- showmode is provided by lualine
		vim.opt.laststatus = 3 -- have a single global statusline
	end,
	opts = {
		extensions = { "neo-tree" },
		sections = {
			lualine_c = {
				{
					"filename",
					path = 1,
				},
			},
			lualine_x = {
				"encoding",
				"filetype",
			},
		},
	},
	config = function(_, opts)
		require("lualine").setup(opts)
	end,
}

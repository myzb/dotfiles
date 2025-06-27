return {
	-- Bottom statusline
	"nvim-lualine/lualine.nvim",
	dependencies = { "echasnovski/mini.nvim" }, -- icon support
	event = "ColorScheme",
	init = function()
		vim.opt.showmode = false -- showmode is provided by lualine
		vim.opt.laststatus = 3 -- have a single global statusline
	end,
	opts = {
		extensions = { "neo-tree" },
		sections = {
			lualine_b = {
				{
					"branch",
					icon = "",
				},
				"diff",
				{
					"diagnostics",
					symbols = {
						error = " ",
						warn = " ",
						info = " ",
						hint = " ",
					},
				},
			},
			lualine_c = {
				{
					"filename",
					path = 1,
				},

				"searchcount",
			},
			lualine_x = {
				"encoding",
				{
					"filetype",
					colored = false,
				},
			},
			lualine_y = {
				{
					"progress",
					icon = " ",
				},
			},
		},
	},
}

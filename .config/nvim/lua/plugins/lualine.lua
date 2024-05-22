return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "ColorScheme",
	init = function()
		vim.opt.showmode = false -- showmode is provided by lualine
		vim.opt.laststatus = 3 -- have a single global statusline
	end,
	config = function()
		require("lualine").setup({
			extensions = { "neo-tree" },
			-- options = {
			-- 	component_separators = "",
			-- 	section_separators = { left = "", right = "" },
			-- },
			-- sections = {
			-- 	lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
			-- 	lualine_b = { "filename", "branch" },
			-- 	lualine_c = {"diff", "diagnostics" },
			-- 	lualine_x = { "encoding"},
			-- 	lualine_y = { "filetype", "progress" },
			-- 	lualine_z = {
			-- 		{ "location", separator = { right = "" }, left_padding = 2 },
			-- 	},
			-- },
			-- inactive_sections = {
			-- 	lualine_a = { "filename" },
			-- 	lualine_b = {},
			-- 	lualine_c = {},
			-- 	lualine_x = {},
			-- 	lualine_y = {},
			-- 	lualine_z = { "location" },
			-- },
		})
	end,
}

return {
	{
		"nvimtools/none-ls.nvim",
	},
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		config = function()
			require("mason").setup()
			require("mason-null-ls").setup({
				ensure_installed = {
					-- Sources available via Mason.
					"stylua",
				},
				automatic_installation = false,
				handlers = {},
			})
			require("null-ls").setup({
				sources = {
					-- Anything not available via Mason.
				},
			})
		end,
	},
}

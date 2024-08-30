return {
	{
		"nvim-treesitter/nvim-treesitter-context",
		opts = { mode = "cursor", max_lines = 1 },
	},
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"RRethy/nvim-treesitter-endwise", -- autocomplete x -> end statements (lua, ruby, ...)
		},
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				-- Default needed
				"c",
				"lua",
				"vim",
				"vimdoc",
				"query",
			},
			sync_install = false,
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
			endwise = { enable = true },
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}

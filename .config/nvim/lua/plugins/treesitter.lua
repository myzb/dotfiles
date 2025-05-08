return {
	{
		"nvim-treesitter/nvim-treesitter-context",
		opts = {
			mode = "cursor",
			max_lines = 1,
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"RRethy/nvim-treesitter-endwise", -- autocomplete 'x {...} end' statements (lua, ruby, ...)
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				-- Default needed
				"c",
				"diff",
				"lua",
				"markdown",
				"markdown_inline",
				"vim",
				"vimdoc",
				"query",
			},
			sync_install = false,
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
			endwise = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<tab>",
					node_incremental = "<tab>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
			textobjects = {
				move = {
					enable = true,
					goto_next_start = {
						["]f"] = "@function.outer",
						["]c"] = "@class.outer",
						["]a"] = "@parameter.inner",
					},
					goto_next_end = {
						["]F"] = "@function.outer",
						["]C"] = "@class.outer",
						["]A"] = "@parameter.inner",
					},
					goto_previous_start = {
						["[f"] = "@function.outer",
						["[c"] = "@class.outer",
						["[a"] = "@parameter.inner",
					},
					goto_previous_end = {
						["[F"] = "@function.outer",
						["[C"] = "@class.outer",
						["[A"] = "@parameter.inner",
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<Leader>a"] = "@parameter.inner",
					},
					swap_previous = {
						["<Leader>A"] = "@parameter.inner",
					},
				},
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}

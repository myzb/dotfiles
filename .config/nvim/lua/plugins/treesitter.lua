return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			-- "RRethy/nvim-treesitter-endwise", -- autocomplete 'x {...} end' statements (e.g. lua)
		},
		lazy = false, -- does not support lazy loading
		branch = "main",
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				-- Default needed
				"c",
				-- "diff",
				"lua",
				-- "markdown",
				-- "markdown_inline",
				-- "vim",
				-- "vimdoc",
				-- "query",
			},
			-- endwise = { enable = true },
			-- incremental_selection = {
			-- 	enable = true,
			-- 	keymaps = {
			-- 		init_selection = "<tab>",
			-- 		node_incremental = "<tab>",
			-- 		scope_incremental = false,
			-- 		node_decremental = "<bs>",
			-- 	},
			-- },
		},
		config = function(_, opts)
			-- Neovim builtin treesitter provides some builtin parsers, install extra
			-- parsers provided by nvim-treesitter. They can coexist.
			require("nvim-treesitter").install(opts.ensure_installed)

			-- Try to start treesitter by default for any filetype. Bail if no builtin
			-- nor nvim-treesitter parser for filetype is available.
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("treesitter.setup", {}),
				callback = function(args)
					local bufnr = args.buf
					local ftype = args.match

					-- `*.language.add()` can be used to check parser availability
					local lang = vim.treesitter.language.get_lang(ftype) or ftype
					if not vim.treesitter.language.add(lang) then
						return
					end

					-- Enable folds
					-- vim.wo.foldmethod = "expr"
					-- vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"

					-- Start treesitter highlighting
					vim.treesitter.start(bufnr, lang)

					-- Use nvim-treesitter's indentexpr
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		branch = "main",
		opts = {
			move = {
				set_jumps = true,
			},
			select = {
				lookahead = true,
				selection_modes = {
					["@parameter.outer"] = "v", -- charwise
					["@function.outer"] = "V", -- linewise
					["@class.outer"] = "<c-v>", -- blockwise
				},
				include_surrounding_whitespace = false,
			},
		},
		-- stylua: ignore
		keys = {
			-- select
			{
				"af",
				function() require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects") end,
				mode = { "x", "o" },
				desc = "function",
			},
			{
				"if",
				function() require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects") end,
				mode = { "x", "o" },
				desc = "function",
			},
			{
				"ac",
				function() require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects") end,
				mode = { "x", "o" },
				desc = "class",
			},
			{
				"ic",
				function() require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects") end,
				mode = { "x", "o" },
				desc = "class",
			},
			{
				"ao",
				function() require("nvim-treesitter-textobjects.select").select_textobject("@local.scope", "locals") end,
				mode = { "x", "o" },
				desc = "scope",
			},
			-- swap
			{
				"<leader>a",
				function() require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner") end,
				mode = "n",
				desc = "Swap parameter next",
			},
			{
				"<leader>A",
				function() require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner") end,
				mode = "n",
				desc = "Swap parameter previous",
			},
			-- move
			{
				"]m",
				function() require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects") end,
				mode = { "n", "x", "o" },
				desc = "Next method start",
			},
			{
				"]M",
				function() require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects") end,
				mode = { "n", "x", "o" },
				desc = "Next method end",
			},
			{
				"[m",
				function() require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects") end,
				mode = { "n", "x", "o" },
				desc = "Previous method start",
			},
			{
				"[M",
				function() require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects") end,
				mode = { "n", "x", "o" },
				desc = "Previous method end",
			},
			{
				"]c",
				function() require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects") end,
				mode = { "n", "x", "o" },
				desc = "Next class start",
			},
			{
				"]C",
				function() require("nvim-treesitter-textobjects.move").goto_next_end("@class.outer", "textobjects") end,
				mode = { "n", "x", "o" },
				desc = "Next class end",
			},
			{
				"[c",
				function() require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects") end,
				mode = { "n", "x", "o" },
				desc = "Previous class start",
			},
			{
				"[C",
				function() require("nvim-treesitter-textobjects.move").goto_previous_end("@class.outer", "textobjects") end,
				mode = { "n", "x", "o" },
				desc = "Previous class end",
			},
			{
				"]a",
				function() require("nvim-treesitter-textobjects.move").goto_next_start("@parameter.inner", "textobjects") end,
				mode = { "n", "x", "o" },
				desc = "Next parameter start",
			},
			{
				"]A",
				function() require("nvim-treesitter-textobjects.move").goto_next_end("@parameter.inner", "textobjects") end,
				mode = { "n", "x", "o" },
				desc = "Next parameter end",
			},
			{
				"[a",
				function() require("nvim-treesitter-textobjects.move").goto_previous_start("@parameter.inner", "textobjects") end,
				mode = { "n", "x", "o" },
				desc = "Previous parameter start",
			},
			{
				"[A",
				function() require("nvim-treesitter-textobjects.move").goto_previous_end("@parameter.inner", "textobjects") end,
				mode = { "n", "x", "o" },
				desc = "Previous parameter end",
			},
			{
				"]o",
				function() require("nvim-treesitter-textobjects.move").goto_next_start("@local.scope", "locals") end,
				mode = { "n", "x", "o" },
				desc = "Next scope start",
			},
			{
				"]O",
				function() require("nvim-treesitter-textobjects.move").goto_next_end("@local.scope", "locals") end,
				mode = { "n", "x", "o" },
				desc = "Next scope end",
			},
			{
				"[o",
				function() require("nvim-treesitter-textobjects.move").goto_previous_start("@local.scope", "locals") end,
				mode = { "n", "x", "o" },
				desc = "Previous scope start",
			},
			{
				"[O",
				function() require("nvim-treesitter-textobjects.move").goto_previous_end("@local.scope", "locals") end,
				mode = { "n", "x", "o" },
				desc = "Previous scope end",
			},
			{
				";", function() require("nvim-treesitter-textobjects.repeatable_move").repeat_last_move() end,
				mode = { "n", "x", "o" },
				desc = "Repeat last move forward",
			},
			{
				",", function() require("nvim-treesitter-textobjects.repeatable_move").repeat_last_move_opposite() end,
				mode = { "n", "x", "o" },
				desc = "Repeat last move backward",
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "VeryLazy",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			mode = "cursor",
			max_lines = 1,
		},
		-- stylua: ignore
		keys = {
			{
				"[u",
				function() require("treesitter-context").go_to_context(vim.v.count1) end,
				mode = "n",
				desc = "Up context",
				silent = true,
			},
		},
	},
}

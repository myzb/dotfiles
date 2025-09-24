return {
	"nvim-mini/mini.nvim",
	config = function()
		-- Better Around/Inside textobjects
		require("mini.ai").setup({ n_lines = 500 })

		-- Add/delete/replace surroundings (brackets, quotes, etc.)
		require("mini.surround").setup()

		-- Icon Support
		require("mini.icons").setup()
		MiniIcons.tweak_lsp_kind() -- add 'kind icon' to completion menu
		MiniIcons.mock_nvim_web_devicons() -- mock web_devicons plugin

		-- Highlight certain patterns
		local mini_hipatterns = require("mini.hipatterns")
		mini_hipatterns.setup({
			highlighters = {
				-- Highlight 'FIXME', 'HACK', 'TODO', 'NOTE'
				fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
				hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
				todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
				note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

				-- Highlight hex color strings (`#rrggbb`) using that color
				hex_color = mini_hipatterns.gen_highlighter.hex_color(),
			},
		})

		-- Auotpairs for braces, bracket pairs, etc.
		local mini_pairs = require("mini.pairs")
		mini_pairs.setup()

		-- Completion Menu
		require("mini.completion").setup({
			lsp_completion = {
				source_func = "omnifunc",
				auto_setup = false, -- setup via "LspAttach"
			},
			window = {
				info = { border = "none" },
				signature = { border = "none" },
			},
		})

		-- Disable completion menu for some buffers
		local f = function(args)
			vim.b[args.buf].minicompletion_disable = true
		end
		vim.api.nvim_create_autocmd("Filetype", { pattern = "neo-tree-popup", callback = f })

		-- Multistep keymaps
		local map_multistep = require("mini.keymap").map_multistep

		map_multistep("i", "<Tab>", { "pmenu_next" })
		map_multistep("i", "<S-Tab>", { "pmenu_prev" })
		map_multistep("i", "<CR>", { "pmenu_accept", "minipairs_cr" })
		map_multistep("i", "<BS>", { "minipairs_bs" })
	end,
}

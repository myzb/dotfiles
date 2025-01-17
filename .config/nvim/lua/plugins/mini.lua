return {
	"echasnovski/mini.nvim",
	config = function()
		-- Better Around/Inside textobjects
		require("mini.ai").setup({ n_lines = 500 })

		-- Add/delete/replace surroundings (brackets, quotes, etc.)
		require("mini.surround").setup()

		-- Icon Support
		require("mini.icons").setup()
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

		-- Highlight trailing spaces
		require("mini.trailspace").setup()
	end,
}

return {
	"echasnovski/mini.nvim",
	config = function()
		-- Better Around/Inside textobjects
		--
		-- Examples:
		--  - va)  - [V]isually select [A]round [)]paren
		--  - yinq - [Y]ank [I]nside [N]ext [']quote
		--  - ci'  - [C]hange [I]nside [']quote
		require("mini.ai").setup({ n_lines = 500 })

		-- Add/delete/replace surroundings (brackets, quotes, etc.)
		--
		-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
		-- - sd'   - [S]urround [D]elete [']quotes
		-- - sr)'  - [S]urround [R]eplace [)] [']
		require("mini.surround").setup()

		-- Icon Support
		require("mini.icons").setup()

		MiniIcons.tweak_lsp_kind() -- add icon to completion menu
		MiniIcons.mock_nvim_web_devicons() -- mock web_devicons plugin

		-- Auotpairs for braces, bracket pairs, etc.
		require("mini.pairs").setup()

		-- Highlight certain patterns
		local hipatterns = require("mini.hipatterns")
		hipatterns.setup({
			highlighters = {
				-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
				fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
				hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
				todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
				note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

				-- Highlight hex color strings (`#rrggbb`) using that color
				hex_color = hipatterns.gen_highlighter.hex_color(),
			},
		})

		-- Completion Menu
		require("mini.completion").setup({
			lsp_completion = {
				source_func = "omnifunc",
				auto_setup = false, -- setup via "LspAttach"
			},
		})

		local imap_expr = function(lhs, rhs)
			vim.keymap.set("i", lhs, rhs, { expr = true })
		end
		imap_expr("<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]])
		imap_expr("<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]])

		local keycode = vim.keycode or function(x)
			return vim.api.nvim_replace_termcodes(x, true, true, true)
		end
		local keys = {
			["cr"] = keycode("<CR>"),
			["ctrl-y"] = keycode("<C-y>"),
			["ctrl-y_cr"] = keycode("<C-y><CR>"),
		}

		_G.cr_action = function()
			if vim.fn.pumvisible() ~= 0 then
				-- If popup is visible, confirm selected item or add new line otherwise
				local item_selected = vim.fn.complete_info()["selected"] ~= -1
				return item_selected and keys["ctrl-y"] or keys["ctrl-y_cr"]
			else
				-- If popup is not visible, use plain `<CR>`. You might want to customize
				-- according to other plugins. For example, to use 'mini.pairs', replace
				-- next line with `return require('mini.pairs').cr()`
				return require("mini.pairs").cr()
			end
		end

		vim.keymap.set("i", "<CR>", "v:lua._G.cr_action()", { expr = true })
	end,
}

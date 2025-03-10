return {
	"echasnovski/mini.nvim",
	config = function()
		-- Better Around/Inside textobjects
		require("mini.ai").setup({ n_lines = 500 })

		-- Add/delete/replace surroundings (brackets, quotes, etc.)
		require("mini.surround").setup()

		-- Icon Support
		require("mini.icons").setup()
		MiniIcons.tweak_lsp_kind() -- add icon to completion menu
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

		local imap_expr = function(lhs, rhs)
			vim.keymap.set("i", lhs, rhs, { expr = true })
		end

		-- Keybind: Tab/S-Tab navigation in popup menus
		imap_expr("<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]])
		imap_expr("<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<C-d>"]])

		-- Keybind: CR to confirm selection in popup menus
		imap_expr("<CR>", function()
			if vim.fn.pumvisible() ~= 0 then
				local sel = vim.fn.complete_info()["selected"] ~= -1
				return sel and "<C-y>" or "<C-y><CR>"
			else
				return mini_pairs.cr()
			end
		end)

		-- Disable completion menu for snacks_picker
		local f = function(args)
			vim.b[args.buf].minicompletion_disable = true
		end
		vim.api.nvim_create_autocmd("Filetype", { pattern = "snacks_picker_input", callback = f })

		-- Highlight trailing spaces
		require("mini.trailspace").setup()
	end,
}

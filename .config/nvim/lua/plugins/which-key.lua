return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.opt.timeout = true
		vim.opt.timeoutlen = 300
	end,
	opts = {
		plugins = {
			marks = true,
			registers = true,
			spelling = {
				enabled = true,
				suggestions = 20,
			}
		},
		ignore_missing = false,
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
		wk.register({
			b = { name = "Buffers" },
			f = { name = "Find" },
			l = { name = "LSP" },
		}, { prefix = "<leader>" })
		wk.register({
			g = { name = "Go" },
		})
	end,
}

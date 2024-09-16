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
			},
		},
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
		wk.add({
			-- { "<leader>b", desc = "Buffers"},
			-- { "<leader>f", desc = "Find" },
			-- { "<leader>l", desc = "LSP" },
			-- { "g", group = "Go" },
		})
	end,
}

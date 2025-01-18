return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		spec = {
			{ "<C-t>", desc = "Jump back tag stack" },

		}
	},
	keys = {
		{
			"<leader>?",
			function() require("which-key").show({ global = false }) end,
			desc = "Buffer Keymaps (which-key)"
		}
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
	end,
}

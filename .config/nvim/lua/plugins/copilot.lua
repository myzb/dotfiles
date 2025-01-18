return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		opts = {},
		config = function(_, opts)
			require("copilot").setup(opts)
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "zbirenbaum/copilot.lua" },
			{ "nvim-lua/plenary.nvim" },
		},
		cmd = "CopilotChat",
		build = "make tiktoken",
		cond = function()
			return vim.fn.executable("make") == 1
		end,
		opts = {
			-- debug = true,
		},
	},
}

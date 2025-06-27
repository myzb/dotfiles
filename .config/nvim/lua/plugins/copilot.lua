return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		lazy = true,
		opts = {},
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
		opts = {},
	},
}

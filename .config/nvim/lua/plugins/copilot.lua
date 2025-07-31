return {
	"CopilotC-Nvim/CopilotChat.nvim",
	dependencies = {
		{ "nvim-lua/plenary.nvim", branch = "master" },
	},
	cmd = "CopilotChat",
	build = "make tiktoken",
	cond = function()
		return vim.fn.executable("make") == 1
	end,
	opts = {},
}

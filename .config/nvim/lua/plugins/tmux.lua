return {
	"christoomey/vim-tmux-navigator",
	cmd = {
		"TmuxNavigateLeft",
		"TmuxNavigateDown",
		"TmuxNavigateUp",
		"TmuxNavigateRight",
		"TmuxNavigatePrevious",
	},
	keys = {
		{ "<C-h>", "<Cmd><C-U>TmuxNavigateLeft<CR>", desc = "Navigate Left" },
		{ "<C-j>", "<Cmd><C-U>TmuxNavigateDown<CR>", desc = "Navigate Down" },
		{ "<C-k>", "<Cmd><C-U>TmuxNavigateUp<CR>", desc = "Navigate Up" },
		{ "<C-l>", "<Cmd><C-U>TmuxNavigateRight<CR>", desc = "Navigate Right" },
		{ "<C-\\>", "<Cmd><C-U>TmuxNavigatePrevious<CR>", desc = "Navigate Previous" },
	},
}

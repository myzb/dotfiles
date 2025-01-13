return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = { "echasnovski/mini.nvim" },
	cmd = "FzfLua",
	keys = {
		-- Basic keymaps
		{ "<Leader>sh", "<Cmd>FzfLua helptags<CR>", desc = "Search help" },
		{ "<Leader>sk", "<Cmd>FzfLua keymaps<CR>", desc = "Search keymaps" },
		{ "<Leader>sf", "<Cmd>FzfLua files<CR>", desc = "Search files" },
		{ "<Leader>ss", "<Cmd>FzfLua builtin<CR>", desc = "Search select" },
		{ "<Leader>sw", "<Cmd>FzfLua grep_cword<CR>", desc = "Search current word" },
		{ "<Leader>sg", "<Cmd>FzfLua live_grep<CR>", desc = "Search by grep" },
		{ "<Leader>sr", "<Cmd>FzfLua resume<CR>", desc = "Search resume" },
		{ "<Leader>s.", "<Cmd>FzfLua oldfiles<CR>", desc = "Search recent files" },
		{ "<Leader><Leader>", "<Cmd>FzfLua buffers<CR>", desc = "Search open buffers" },
		{ "<Leader>/", "<Cmd>FzfLua grep_curbuf<CR>", desc = "Search in current buffer" },
		{ "<Leader>sF", "<Cmd>FzfLua git_files<CR>", desc = "Search git-files" },

		-- Advanced keymaps
		{
			"<Leader>sn",
			function()
				require("fzf-lua").files({
					cwd = vim.fn.stdpath("config"),
					winopts = { title = "Neovim Config Files " },
				})
			end,
			desc = "Search neovim config",
		},
		{
			"<Leader>sG",
			function()
				require("fzf-lua").live_grep({
					cmd = "git grep --line-number --column --color=always",
					winopts = { title = " Search by grep (git-files) " },
				})
			end,
			desc = "Search by grep (git)",
		},
	},
	config = function(_, opts)
		local fzf = require("fzf-lua")
		fzf.setup({
			"default-title",
			winopts = {
				backdrop = 100,
			},
			files = {
				cwd_prompt = false,
				actions = {
					["alt-i"] = { fzf.actions.toggle_ignore },
					["alt-h"] = { fzf.actions.toggle_hidden },
				},
			},
			grep = {
				actions = {
					["alt-i"] = { fzf.actions.toggle_ignore },
					["alt-h"] = { fzf.actions.toggle_hidden },
				},
			},
		})
	end,
}

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
		{ "<Leader><Leader>", "<Cmd>FzfLua buffers<CR>", desc = "Search open buffers" },
		{ "<Leader>/", "<Cmd>FzfLua grep_curbuf<CR>", desc = "Search in current buffer" },
		{ "<Leader>sF", "<Cmd>FzfLua git_files<CR>", desc = "Search git-files" },
		{ "<Leader>st", "<Cmd>FzfLua git_status<CR>", desc = "Search git-status" },
		{ "<Leader>sb", "<Cmd>FzfLua marks<CR>", desc = "Search marks" },
		{ "<Leader>sl", "<Cmd>FzfLua loclist<CR>", desc = "Search loclist" },
		{ "<Leader>sq", "<Cmd>FzfLua quickfix<CR>", desc = "Search quickfix" },
		{
			"<Leader>sG",
			function()
				require("fzf-lua").live_grep({ cmd = "git grep -n --column --color" })
			end,
			desc = "Search by grep (git)",
		},

		-- Advanced keymaps
		{ "<Leader>so", "<Cmd>FzfLua oldfiles cwd=" .. vim.uv.cwd() .. "<CR>", desc = "Search oldfiles" },
		{ "<Leader>sn", "<Cmd>FzfLua files cwd=" .. vim.fn.stdpath("config") .. "<CR>", desc = "Search neovim config" },
		-- { "<Leader>sG", "<Cmd>FzfLua live_grep cmd='git grep -n --column --color'<CR>", desc = "Search by grep (git)" },
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

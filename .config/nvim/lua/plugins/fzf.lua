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
		{ "<Leader>sG", "<Cmd>FzfLua live_grep_glob cwd=" .. vim.uv.cwd() .. "<CR>", desc = "Search by grep (glob)" },
		{ "<Leader>sr", "<Cmd>FzfLua resume<CR>", desc = "Search resume" },
		{ "<Leader><Leader>", "<Cmd>FzfLua buffers<CR>", desc = "Search open buffers" },
		{ "<Leader>/", "<Cmd>FzfLua grep_curbuf<CR>", desc = "Search in current buffer" },
		{ "<Leader>sF", "<Cmd>FzfLua git_files<CR>", desc = "Search git-files" },
		{ "<Leader>sT", "<Cmd>FzfLua git_status<CR>", desc = "Search git-status" },
		{ "<Leader>sb", "<Cmd>FzfLua marks<CR>", desc = "Search marks" },
		{ "<Leader>sl", "<Cmd>FzfLua loclist<CR>", desc = "Search loclist" },
		{ "<Leader>sq", "<Cmd>FzfLua quickfix<CR>", desc = "Search quickfix" },
		{ "<Leader>sO", "<Cmd>FzfLua oldfiles<CR>", desc = "Search oldfiles" },
		{ "<Leader>so", "<Cmd>FzfLua oldfiles cwd=" .. vim.uv.cwd() .. "<CR>", desc = "Search oldfiles (cwd)" },
		{ "<Leader>sn", "<Cmd>FzfLua files cwd=" .. vim.fn.stdpath("config") .. "<CR>", desc = "Search neovim config" },
	},
	config = function(_, opts)
		local fzf = require("fzf-lua")
		fzf.setup({
			"default-title",
			winopts = {
				backdrop = 100,
			},
			files = {
				-- cwd_prompt = false,
			},
		})
	end,
}

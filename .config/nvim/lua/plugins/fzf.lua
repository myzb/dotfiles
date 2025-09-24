return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-mini/mini.nvim" }, -- icon support
	cmd = "FzfLua",
	keys = {
		-- stylua: ignore start
		-- Basic keymaps
		{ "<Leader>/", "<Cmd>FzfLua grep_curbuf<CR>", desc = "Search in current buffer" },
		{ "<Leader><Leader>", "<Cmd>FzfLua buffers<CR>", desc = "Search open buffers" },
		{ "<Leader>fz", "<Cmd>FzfLua builtin<CR>", desc = "FzfLua builtin" },
		-- Search
		{ "<Leader>sh", "<Cmd>FzfLua helptags<CR>", desc = "Search help" },
		{ "<Leader>sk", "<Cmd>FzfLua keymaps<CR>", desc = "Search keymaps" },
		{ "<Leader>sw", "<Cmd>FzfLua grep_cword<CR>", desc = "Search current word" },
		{ "<Leader>sg", "<Cmd>FzfLua live_grep_native<CR>", desc = "Search by grep" },
		{ "<Leader>sG", "<Cmd>FzfLua live_grep_glob <CR>", desc = "Search by grep (glob)" },
		{ "<Leader>sr", "<Cmd>FzfLua resume<CR>", desc = "Search resume" },
		{ '<Leader>s"', "<Cmd>FzfLua registers<CR>", desc = "Search registers" },
		{ "<Leader>sb", "<Cmd>FzfLua marks<CR>", desc = "Search marks" },
		{ "<Leader>sj", "<Cmd>FzfLua jumps<CR>", desc = "Search jumps" },
		{ "<Leader>sl", "<Cmd>FzfLua loclist<CR>", desc = "Search loclist" },
		{ "<Leader>sq", "<Cmd>FzfLua quickfix<CR>", desc = "Search quickfix" },
		-- Find
		{ "<Leader>ff", "<Cmd>FzfLua files<CR>", desc = "Find files" },
		{ "<Leader>fo", "<Cmd>FzfLua oldfiles cwd=" .. vim.uv.cwd() .. "<CR>", desc = "Find oldfiles (cwd)" },
		{ "<Leader>fO", "<Cmd>FzfLua oldfiles<CR>", desc = "Find oldfiles" },
		{ "<Leader>fn", "<Cmd>FzfLua files cwd=" .. vim.fn.stdpath("config") .. "<CR>", desc = "Find neovim config" },
		-- LSP
		{ "gd", "<Cmd>FzfLua lsp_definitions<CR>", desc = "Goto definition" },
		{ "gD", "<Cmd>FzfLua lsp_declarations<CR>", desc = "Goto declaration" },
		{ "gr", "<Cmd>FzfLua lsp_references<CR>", desc = "References" },
		{ "gI", "<Cmd>FzfLua lsp_implementations<CR>", desc = "Goto implementation" },
		{ "gy", "<Cmd>FzfLua lsp_typedefs<CR>", desc = "Goto type definition" },
		{ "<leader>ss", "<Cmd>FzfLua lsp_document_symbols<CR>", desc = "LSP document symbols" },
		{ "<leader>sS", "<Cmd>FzfLua lsp_workspace_symbols<CR>", desc = "LSP workspace symbols" },
		{ "<leader>sd", "<Cmd>FzfLua lsp_document_diagnostics<CR>", desc = "LSP document diagnostics" },
		{ "<leader>sD", "<Cmd>FzfLua lsp_workspace_diagnostics<CR>", desc = "LSP workspace diagnostics" },
		-- Git
		{ "<Leader>gs", "<Cmd>FzfLua git_status<CR>", desc = "Search git-status" },
		{ "<Leader>gf", "<Cmd>FzfLua git_files<CR>", desc = "Search git-files" },
		{ "<leader>gb", "<Cmd>FzfLua git_branches<CR>", desc = "Git branches" },
		{ "<leader>gL", "<Cmd>FzfLua git_commits<CR>", desc = "Git workspace log" },
		{ "<leader>gl", "<Cmd>FzfLua git_bcommits<CR>", desc = "Git document log" },
		{ "<leader>gB", "<Cmd>FzfLua git_blame<CR>", desc = "Git blame" },
		{ "<leader>gu", "<Cmd>FzfLua git_files cmd='git diff --name-only --diff-filter=U --relative'<CR>", desc = "Git unmerged" },
		-- stylua: ignore end
	},
	opts = {
		"default-title",
		winopts = {
			backdrop = 100,
		},
		files = {
			cwd_prompt = false,
		},
	},
}

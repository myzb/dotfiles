return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = { "echasnovski/mini.nvim" },
	-- cmd = "FzfLua",
	config = function()
		-- calling `setup` is optional for customization
		local fzf = require("fzf-lua")
		fzf.setup({
			"default-title",
			winopts = {
				backdrop = 100,
			},
		})

		-- Basic keymaps
		vim.keymap.set("n", "<Leader>sh", fzf.helptags, { desc = "Search help" })
		vim.keymap.set("n", "<Leader>sk", fzf.keymaps, { desc = "Search keymaps" })
		vim.keymap.set("n", "<Leader>sf", fzf.files, { desc = "Search files" })
		vim.keymap.set("n", "<Leader>ss", fzf.builtin, { desc = "Search select" })
		vim.keymap.set("n", "<Leader>sw", fzf.grep_cword, { desc = "Search current word" })
		vim.keymap.set("n", "<Leader>sg", fzf.live_grep, { desc = "Search by grep" })
		vim.keymap.set("n", "<Leader>sr", fzf.resume, { desc = "Search resume" })
		vim.keymap.set("n", "<Leader>s.", fzf.oldfiles, { desc = 'Search recent files ("." for repeat)' })
		vim.keymap.set("n", "<Leader><Leader>", fzf.buffers, { desc = "Search open buffers" })
		vim.keymap.set("n", "<Leader>/", fzf.lgrep_curbuf, { desc = "Search in current buffer" })

		-- Advanced keymaps
		vim.keymap.set("n", "<Leader>s/", function()
			fzf.live_grep({
				grep_open_files = true,
				prompt_title = "Live Grep in Open Files",
			})
		end, { desc = "Search in open files" })

		vim.keymap.set("n", "<Leader>sn", function()
			fzf.files({
				cwd = vim.fn.stdpath("config"),
			})
		end, { desc = "Search neovim config" })

		vim.keymap.set("n", "<Leader>sF", function()
			fzf.files({
				hidden = true,
				no_ignore = true,
				prompt_title = "Find All Files",
			})
		end, { desc = "Search all files" })
		vim.keymap.set("n", "<Leader>sG", function()
			fzf.live_grep({
				hidden = true,
				no_ignore = true,
				winopts = { title = " Search All by Grep " },
			})
		end, { desc = "Search all by grep" })
	end,
}

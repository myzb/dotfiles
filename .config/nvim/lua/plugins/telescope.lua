return {
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		lazy = true,
		build = "make",
		cond = function()
			return vim.fn.executable("make") == 1
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		enabled = false,
		event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			"nvim-telescope/telescope-fzf-native.nvim",
		},
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})

			-- Load extensions
			require("telescope").load_extension("ui-select")
			require("telescope").load_extension("fzf")

			-- Basic keymaps
			local ts_builtin = require("telescope.builtin")
			vim.keymap.set("n", "<Leader>sh", ts_builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<Leader>sk", ts_builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			vim.keymap.set("n", "<Leader>sf", ts_builtin.find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<Leader>ss", ts_builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
			vim.keymap.set("n", "<Leader>sw", ts_builtin.grep_string, { desc = "[S]earch current [W]ord" })
			vim.keymap.set("n", "<Leader>sg", ts_builtin.live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<Leader>sd", ts_builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			vim.keymap.set("n", "<Leader>sr", ts_builtin.resume, { desc = "[S]earch [R]esume" })
			vim.keymap.set("n", "<Leader>s.", ts_builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
			vim.keymap.set("n", "<Leader><Leader>", ts_builtin.buffers, { desc = "[ ] Find existing buffers" })

			-- Advanced keymaps
			vim.keymap.set("n", "<Leader>/", function()
				ts_builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 0,
					previewer = false,
				}))
			end, { desc = "[/] Fuzzily search in current buffer" })

			vim.keymap.set("n", "<Leader>s/", function()
				ts_builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "[S]earch [/] in Open Files" })

			vim.keymap.set("n", "<Leader>sn", function()
				ts_builtin.find_files({
					cwd = vim.fn.stdpath("config"),
				})
			end, { desc = "[S]earch [N]eovim files" })

			vim.keymap.set("n", "<Leader>sF", function()
				ts_builtin.find_files({
					hidden = true,
					no_ignore = true,
					prompt_title = "Find All Files",
				})
			end, { desc = "[S]earch All [F]iles" })
			vim.keymap.set("n", "<Leader>sG", function()
				ts_builtin.live_grep({
					hidden = true,
					no_ignore = true,
					prompt_title = "Find All by Grep",
				})
			end, { desc = "[S]earch All by [G]rep" })
		end,
	},
}

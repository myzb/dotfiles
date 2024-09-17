local keymap = vim.keymap.set

-- Navigate within insert mode
keymap("i", "<c-k>", "<Up>", { desc = "Up" })
keymap("i", "<c-j>", "<Down>", { desc = "Down" })
keymap("i", "<c-h>", "<Left>", { desc = "Left" })
keymap("i", "<c-l>", "<Right>", { desc = "Right" })

keymap("n", "<esc>", "<cmd> nohlsearch <cr>", { desc = "Hide search highlight" })
keymap("n", "<leader>nr", "<cmd> set relativenumber! <cr>", { desc = "Toogle relative line numbers" })

-- Change indent tab size
vim.keymap.set("n", "<leader>it", function()
	vim.ui.input({ prompt = "Indent tab to: " }, function(input)
		vim.opt.tabstop = tonumber(input)
		vim.opt.softtabstop = tonumber(input)
		vim.opt.shiftwidth = tonumber(input)
		vim.opt.expandtab = false
	end)
end, { desc = "Indent tabs" })

-- Change indent space size
vim.keymap.set("n", "<leader>is", function()
	vim.ui.input({ prompt = "Indent space to: " }, function(input)
		vim.opt.tabstop = 8
		vim.opt.softtabstop = tonumber(input)
		vim.opt.shiftwidth = tonumber(input)
		vim.opt.expandtab = true
	end)
end, { desc = "Indent spaces" })

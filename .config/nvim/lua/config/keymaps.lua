local map = vim.keymap.set

-- Navigate within insert mode
map("i", "<c-k>", "<Up>", { desc = "Up" })
map("i", "<c-j>", "<Down>", { desc = "Down" })
map("i", "<c-h>", "<Left>", { desc = "Left" })
map("i", "<c-l>", "<Right>", { desc = "Right" })

map("n", "<esc>", "<cmd> nohlsearch <cr>", { desc = "Hide search highlight" })
map("n", "<leader>nr", "<cmd> set relativenumber! <cr>", { desc = "Toogle relative line numbers" })

-- Change indent tab size
map("n", "<leader>it", function()
	vim.ui.input({ prompt = "Indent tab to: " }, function(input)
		vim.opt.tabstop = tonumber(input)
		vim.opt.softtabstop = tonumber(input)
		vim.opt.shiftwidth = tonumber(input)
		vim.opt.expandtab = false
	end)
end, { desc = "Indent tabs" })

-- Change indent space size
map("n", "<leader>is", function()
	vim.ui.input({ prompt = "Indent space to: " }, function(input)
		vim.opt.tabstop = 8
		vim.opt.softtabstop = tonumber(input)
		vim.opt.shiftwidth = tonumber(input)
		vim.opt.expandtab = true
	end)
end, { desc = "Indent spaces" })

local map = vim.keymap.set

-- Navigate within insert mode
map("i", "<C-k>", "<Up>", { desc = "Up" })
map("i", "<C-j>", "<Down>", { desc = "Down" })
map("i", "<C-h>", "<Left>", { desc = "Left" })
map("i", "<C-l>", "<Right>", { desc = "Right" })

-- Other Keybinds
map("n", "<Esc>", "<Cmd> nohlsearch <CR>", { desc = "Hide search highlight" })
map("n", "<Leader>tr", "<Cmd> set relativenumber! <CR>", { desc = "Toggle relative line numbers" })

-- Toggle whitespace characters
map("n", "<Leader>tw", function()
	if string.find(vim.o.listchars, "space: ") then
		vim.opt.listchars = { space = "·", tab = "╶─", trail = "·", nbsp = "␣" }
		vim.opt.list = true
	else
		vim.opt.listchars = { space = " ", tab = "  ", trail = "·", nbsp = " " }
		vim.opt.list = true
	end
end, { desc = "Toggle whitespaces" })

-- Change indent tab size
map("n", "<Leader>it", function()
	vim.ui.input({ prompt = "Indent tab to: " }, function(input)
		vim.opt.tabstop = tonumber(input)
		vim.opt.softtabstop = -1
		vim.opt.shiftwidth = 0
		vim.opt.expandtab = false
	end)
end, { desc = "Indent tabs" })

-- Change indent space size
map("n", "<Leader>is", function()
	vim.ui.input({ prompt = "Indent space to: " }, function(input)
		vim.opt.tabstop = 8
		vim.opt.softtabstop = -1
		vim.opt.shiftwidth = tonumber(input)
		vim.opt.expandtab = true
	end)
end, { desc = "Indent spaces" })

-- Change indent mixed tab/spaces size
map("n", "<Leader>im", function()
	vim.ui.input({ prompt = "Indent mixed to: " }, function(input)
		vim.opt.tabstop = 8
		vim.opt.softtabstop = -1
		vim.opt.shiftwidth = tonumber(input)
		vim.opt.expandtab = false
	end)
end, { desc = "Indent mixed" })

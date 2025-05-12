vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.expandtab = true
vim.opt.tabstop = 8
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
--vim.opt.smarttab = true

vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true -- highlight line the cursor is at

vim.opt.number = true -- enable line numbers
vim.opt.relativenumber = true -- enable relative numbers

vim.opt.cmdheight = 0 -- autoshow cmdline only when needed

vim.opt.colorcolumn = "80" -- column at 80 chars
-- vim.opt.listchars = { space = "·", tab = "╶─", trail = "·", nbsp = "␣" }
vim.opt.listchars = { space = " ", tab = "  ", trail = "·", nbsp = " " }
vim.opt.list = true -- show/hide listchars

vim.opt.ruler = false
vim.opt.termguicolors = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true -- highlight search matches by default
vim.opt.mouse = "a" -- enable mouse

vim.opt.signcolumn = "yes" -- sign colum on by default
vim.opt.inccommand = "split" -- preview substitions

vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.scrolloff = 10 -- min number of screen lines to keep above cursor when scrolling

vim.opt.shortmess:append("I") -- disable welcome message

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.g.netrw_banner = 0
vim.g.netrw_mouse = 2
--vim.g.loaded_netrw = true
--vim.g.loaded_netrwPlugin = trouble

vim.opt.fillchars:append("eob: ") -- do not show end-of-buffer tilde
vim.opt.scrolloff = 10 -- number of lines to keep above/below cursor

-- vim.opt.winborder = "none" -- set all 'float' borders to none

-- Highlight text when yaking
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

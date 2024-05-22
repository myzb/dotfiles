local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("options")
require("keymaps")

local opts = {
	performance = {
		rtp = {
			disabled_plugins = {
				"netrwPlugin",
				"tutor",
			}
		}
	}
}
require("lazy").setup("plugins", opts)

-- load the theme
-- vim.cmd.colorscheme("kanagawa")
vim.cmd.colorscheme("nord")
-- vim.cmd.colorscheme("zenbones")
-- vim.cmd.colorscheme("kanagawabones")
-- vim.cmd.colorscheme("tokyonight-night")
-- vim.cmd.colorscheme("catppuccin")

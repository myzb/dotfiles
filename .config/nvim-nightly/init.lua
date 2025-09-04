vim.g.mapleader = " "
vim.opt.clipboard = "unnamedplus"

-- Linenumber
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.colorcolumn = "80"
vim.opt.signcolumn = "yes"

-- Indentation
vim.opt.expandtab = true -- expand real tabs to spaces
vim.opt.shiftwidth = 4   -- spaces that correspond to an indent level
vim.opt.softtabstop = -1 -- spaces a tab key-press will insert (-1 = same as shiftwidth)
vim.opt.tabstop = 8      -- spaces a real tab character corresponds to

-- Hidden characters
vim.opt.list = true
vim.opt.listchars = { space = " ", tab = "  ", trail = ".", nbsp = " " }

vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.scrolloff = 10

vim.opt.shortmess:append("I") -- Disable "I" welcome message
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.winborder = "none"
vim.opt.termguicolors = true -- Enable 24-bit RGB color

vim.opt.smartindent = true
vim.opt.autoindent = true

-- Statusline
vim.opt.laststatus = 3

vim.pack.add({
	-- { src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/tpope/vim-sleuth" },
	{ src = "https://github.com/nvim-mini/mini.nvim" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/gbprod/nord.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	{ src = 'https://github.com/neovim/nvim-lspconfig' },
	{ src = "https://github.com/mason-org/mason.nvim" },
})

vim.lsp.enable({
	"lua_ls",
	"rust_analyzer",
	"clangd",
	"black",
})

require("gitsigns").setup()
require "mason".setup()
require "mini.pick".setup({
	mappings = {
		choose_marked = "<C-G>"
	},
	window = {
		config = { border = "rounded" }
	},
})
require("mini.completion").setup()

-- Lsp diagnostics display
vim.diagnostic.config({
	virtual_text = false,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.INFO] = " ",
			[vim.diagnostic.severity.HINT] = "󰌵 ",
		},
	},
	update_in_insert = true,
	underline = true,
	seventerity_sort = true,
	float = {
		focusable = false, -- disable mouse/focus
		source = true, -- include diagnostic source
		header = "", -- hide window title
		prefix = "", -- hide diagnostic number
	},
})

-- Statusline
NvimConfig = {}

local function shorten_path(path, keep, sep)
	local segments = vim.split(path, sep)

	-- Keep 1 extra segment for folders
	if segments[#segments] == "" then
		keep = keep + 1
	end

	-- Keep the last `keep` segments un-shortened
	for idx = 1, #segments - keep do
		local segment = segments[idx]
		segments[idx] = segment:sub(1, vim.startswith(segment, ".") and 2 or 1)
	end

	return table.concat(segments, sep)
end

local function filepath()
	local sep = package.config:sub(1, 1)
	local path = vim.fn.fnamemodify(vim.fn.expand("%"), ":p:~")
	local fpath = shorten_path(path, 2, sep)
	return string.format(" %%<%s", fpath)
end

local function lsp()
	local icon = vim.diagnostic.config().signs.text
	local diag = {
		[vim.diagnostic.severity.ERROR] = "Error",
		[vim.diagnostic.severity.WARN]  = "Warn",
		[vim.diagnostic.severity.INFO]  = "Info",
		[vim.diagnostic.severity.HINT]  = "Hint"
	}

	local rv = ""
	for id, name in pairs(diag) do
		local count = vim.tbl_count(vim.diagnostic.get(0, { severity = id }))
		if count ~= 0 then
			rv = rv .. " %#DiagnosticSign" .. name .. "#" .. icon[id] .. count
		end
	end

	return rv .. "  %*"
end

local function git()
	local git_info = vim.b.gitsigns_status_dict
	if not git_info or git_info.head == "" then
		return ""
	end

	local head    = git_info.head
	local added   = git_info.added and (" +" .. git_info.added) or ""
	local changed = git_info.changed and (" ~" .. git_info.changed) or ""
	local removed = git_info.removed and (" -" .. git_info.removed) or ""
	if git_info.added == 0 then added = "" end
	if git_info.changed == 0 then changed = "" end
	if git_info.removed == 0 then removed = "" end

	return table.concat({
		"[ ", -- branch icon
		head,
		added, changed, removed,
		"]",
	})
end

function NvimConfig.statusline()
	return table.concat {
		filepath(),
		" %h%w%m%r", -- nvim default: filestatus
		git(),
		"%=",  -- horizontal fill
		lsp(),
		"%-14.(%l,%c%V%) %P" -- nvim default: lineinfo
	}
end

vim.opt.statusline = "%!v:lua.NvimConfig.statusline()"

-- -----------------------------------------------------------------------------
-- > Keybinds
-- -----------------------------------------------------------------------------

local map = vim.keymap.set
map("n", "<Esc>", "<Cmd> nohlsearch <CR>", { desc = "Hide search highlight" })
map("n", "<Leader>tr", "<Cmd> set relativenumber! <CR>", { desc = "Toggle relative line numbers" })
map("n", "<Leader>ff", "<Cmd> Pick files <CR>", { desc = "Find files" })
map("n", "<Leader>sg", "<Cmd> Pick grep_live <CR>", { desc = "Search by grep" })
map("n", "<Leader>sh", "<Cmd> Pick help <CR>", { desc = "Search help" })
map("n", "<Leader><Leader>", "<Cmd> Pick buffers <CR>", { desc = "Search open buffers" })
map("n", "<Leader>lf", vim.lsp.buf.format, { desc = "Format buffer" })

-- Toggle whitespace characters
map("n", "<Leader>tw", function()
	if string.find(vim.o.listchars, "space: ") then
		vim.opt.listchars = { space = "·", tab = "╶─", trail = "·", nbsp = "␣" }
	else
		vim.opt.listchars = { space = " ", tab = "  ", trail = "·", nbsp = " " }
	end
        vim.opt.list = true
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

-- -----------------------------------------------------------------------------
-- > Theme
-- -----------------------------------------------------------------------------
vim.cmd([[hi! link StatusLine CursorLineNr]])
vim.cmd([[hi! link ColorColumn Cursorline]])
vim.cmd([[hi! link MiniPickBorder Comment]])
vim.cmd([[hi! link MiniPickNormal Normal]])
-- vim.cmd([[hi! link NormalFloat Pmenu]])
-- vim.cmd([[hi! link FloatBorder Pmenu]])

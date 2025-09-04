NvimConfig = {}

-- -----------------------------------------------------------------------------
-- > Options
-- ------------------------------------------------------------------------------

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

-- -----------------------------------------------------------------------------
-- > Plugins
-- -----------------------------------------------------------------------------

vim.pack.add({
	-- { src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/tpope/vim-sleuth" },
	{ src = "https://github.com/nvim-mini/mini.nvim" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/christoomey/vim-tmux-navigator" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	{ src = 'https://github.com/neovim/nvim-lspconfig' },
	{ src = "https://github.com/mason-org/mason.nvim" },
})

-- Icon Support
require("mini.icons").setup()
MiniIcons.tweak_lsp_kind()         -- add 'kind icon' to completion menu
MiniIcons.mock_nvim_web_devicons() -- mock web_devicons plugin

-- Highlight certain patterns
local mini_hipatterns = require("mini.hipatterns")
mini_hipatterns.setup({
	highlighters = {
		-- Highlight 'FIXME', 'HACK', 'TODO', 'NOTE'
		fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
		hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
		todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
		note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

		-- Highlight hex color strings (`#rrggbb`) using that color
		hex_color = mini_hipatterns.gen_highlighter.hex_color(),
	},
})
-- Mini Completion
require("mini.completion").setup()

-- Mini Pick
require("mini.pick").setup({ window = { config = { border = "rounded" } }, })
require("mini.extra").setup()

-- Mini Pick: All files picker
MiniPick.registry.all_files = function()
	local command = { "fd", "--type=f", "--no-follow", "--color=never", "--hidden" }
	local show_with_icons = function(buf_id, items, query)
		return MiniPick.default_show(buf_id, items, query, { show_icons = true })
	end
	local source = { name = "All Files (fd)", show = show_with_icons }
	return MiniPick.builtin.cli({ command = command }, { source = source })
end

-- Auotpairs for braces, bracket pairs, etc.
require("mini.pairs").setup()

-- Better Around/Inside textobjects
require("mini.ai").setup({ n_lines = 500 })

-- Add/delete/replace surroundings (brackets, quotes, etc.)
require("mini.surround").setup()

-- Multistep keymaps
local map_multistep = require("mini.keymap").map_multistep

map_multistep("i", "<Tab>", { "pmenu_next" })
map_multistep("i", "<S-Tab>", { "pmenu_prev" })
map_multistep("i", "<CR>", { "pmenu_accept", "minipairs_cr" })
map_multistep("i", "<BS>", { "minipairs_bs" })

-- Mason
require("mason").setup()

vim.lsp.config("*", { capabilities = MiniCompletion.get_lsp_capabilities() })
vim.lsp.enable({
	"lua_ls",
	"rust_analyzer",
	"clangd",
	"zls",
})

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
	seventerity_sort = true,
	float = {
		source = true, -- include diagnostic source
		header = "", -- hide window title
		prefix = "", -- hide diagnostic number
	},
})

-- Treesitter
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("treesitter.setup", {}),
	callback = function(args)
		local bufnr = args.buf
		local ftype = args.match

		-- `*.language.add()` can be used to check parser availability
		local lang = vim.treesitter.language.get_lang(ftype) or ftype
		if not vim.treesitter.language.add(lang) then
			return
		end

		-- Start treesitter highlighting
		vim.treesitter.start(bufnr, lang)

		-- Use nvim-treesitter's indentexpr
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

-- -----------------------------------------------------------------------------
-- > Statusline
-- -----------------------------------------------------------------------------

local function shortpath()
	local path = vim.fn.expand("%")
	if path == "" then
		return "%<%f"
	end
	local sep = package.config:sub(1, 1)
	local seg = vim.split(path, sep)

	-- Keep the last `2` segments un-shortened
	for i = 1, #seg - 2 do
		local s = seg[i]
		seg[i] = s:sub(1, vim.startswith(s, ".") and 2 or 1)
	end
	return "%<" .. table.concat(seg, sep)
end

local function lsp()
	local s = vim.diagnostic.severity
	local signs = vim.diagnostic.config().signs.text or {}
	local icons = {
		[s.ERROR] = "%#DiagnosticSignError#" .. (signs[s.ERROR] or ""),
		[s.WARN]  = "%#DiagnosticSignWarn#"  .. (signs[s.WARN]  or ""),
		[s.INFO]  = "%#DiagnosticSignInfo#"  .. (signs[s.INFO]  or ""),
		[s.HINT]  = "%#DiagnosticSignHint#"  .. (signs[s.HINT]  or ""),
	}

	local diag = {}
	for i, icon in pairs(icons) do
		local count = vim.tbl_count(vim.diagnostic.get(0, { severity = i }))
		if count ~= 0 then
			table.insert(diag, " " .. icon .. count)
		end
	end
	return table.concat(diag) .. "  %*"
end

local function git()
	local head, status = vim.b.gitsigns_head, vim.b.gitsigns_status
	return head and table.concat({ "[ ", head, (status ~= "") and " " or "", status, "]" }) or ""
end

function NvimConfig.statusline()
	return table.concat {
		shortpath(),
		" %h%w%m%r", -- nvim default: filestatus
		git(),
		"%=",
		lsp(),
		"%-14.(%l,%c%V%) %P"
	}
end

vim.opt.statusline = "%!v:lua.NvimConfig.statusline()"

-- -----------------------------------------------------------------------------
-- > Keybinds
-- -----------------------------------------------------------------------------

local map = vim.keymap.set
map("n", "<Esc>", "<Cmd> nohlsearch <CR>", { desc = "Hide search highlight" })
map("n", "<Leader>tr", "<Cmd> set relativenumber! <CR>", { desc = "Toggle relative line numbers" })
map("n", "<Leader>ff", "<Cmd> Pick files tool='fd' <CR>", { desc = "Find files" })
map("n", "<Leader>fF", "<Cmd> Pick all_files <CR>", { desc = "Find all files" })
map("n", "<Leader>sg", "<Cmd> Pick grep_live <CR>", { desc = "Search by grep" })
map("n", "<Leader>sr", "<Cmd> Pick resume <CR>", { desc = "Search resume" })
map("n", "<Leader>sh", "<Cmd> Pick help <CR>", { desc = "Search help" })
map("n", "<Leader>sk", "<Cmd> Pick keymaps <CR>", { desc = "Search keymaps" })
map("n", "<Leader>/", "<Cmd> Pick buf_lines <CR>", { desc = "Search buffer lines" })
map("n", '<Leader>"', "<Cmd> Pick registers <CR>", { desc = "Search registers" })
map("n", "<Leader><Leader>", "<Cmd> Pick buffers <CR>", { desc = "Search open buffers" })
map("n", "<Leader>lf", vim.lsp.buf.format, { desc = "Format buffer" })

map("n", "<C-h>", "<Cmd><C-U>TmuxNavigateLeft<CR>", { desc = "Navigate left" })
map("n", "<C-j>", "<Cmd><C-U>TmuxNavigateDown<CR>", { desc = "Navigate down" })
map("n", "<C-k>", "<Cmd><C-U>TmuxNavigateUp<CR>", { desc = "Navigate up" })
map("n", "<C-l>", "<Cmd><C-U>TmuxNavigateRight<CR>", { desc = "Navigate right" })
map("n", "<C-\\>", "<Cmd><C-U>TmuxNavigatePrevious<CR>", { desc = "Navigate previous" })

-- Toggle whitespace characters
map("n", "<Leader>tw", function()
	if vim.opt.listchars:get().space == " " then
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
-- > Autocommands
-- -----------------------------------------------------------------------------

-- Highlight text when yaking
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- -----------------------------------------------------------------------------
-- > Theme
-- -----------------------------------------------------------------------------

vim.cmd([[hi! link StatusLine CursorLineNr]])
vim.cmd([[hi! link ColorColumn Cursorline]])
vim.cmd([[hi! link MiniPickBorder Comment]])
vim.cmd([[hi! link MiniPickNormal Normal]])
-- vim.cmd([[hi! link NormalFloat Pmenu]])
-- vim.cmd([[hi! link FloatBorder Pmenu]])

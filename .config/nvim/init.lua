User = {}
-- -----------------------------------------------------------------------------
-- > Options
-- -----------------------------------------------------------------------------

vim.g.mapleader = " "                   -- Set the leader key prefix
vim.opt.clipboard:append("unnamedplus") -- Use the system clipboard for all operations
vim.opt.shortmess:append("I")           -- Disable welcome message ("I")

vim.opt.number = true                   -- Column with line number
vim.opt.relativenumber = true           -- Use relative line numbers
vim.opt.colorcolumn = "80"              -- Column at "x" chars
vim.opt.signcolumn = "yes"              -- Column for git status, diagnostics, etc.
vim.opt.laststatus = 3                  -- Single statusline
vim.opt.cursorline = true               -- Highlight the entire current line
vim.opt.winborder = "none"              -- Disable float borders
vim.opt.termguicolors = true            -- Force enable 24-bit RGB color
vim.opt.wrap = false                    -- Don't break lines
vim.opt.scrolloff = 10                  -- Lines to keep above/below cursor
vim.opt.splitbelow = true               -- Open splits below current
vim.opt.splitright = true               -- Open split right of current
vim.opt.ignorecase = true               -- Ignore case when searching
vim.opt.smartcase = true                -- Fallback to exact case, when upper case is used
vim.opt.foldlevel = 99                  -- Open all folds by default

vim.opt.expandtab = true                -- Expand real tabs to spaces
vim.opt.shiftwidth = 4                  -- Width of one indent level
vim.opt.softtabstop = -1                -- Width of one tab key-press (-1 = same as shiftwidth)
vim.opt.tabstop = 8                     -- Width of a real tab character
vim.opt.autoindent = true               -- Use the indent from the previous line
vim.opt.smartindent = true              -- Attempt to do c-style indentation

vim.opt.list = true                     -- Show hidden characters as:
vim.opt.listchars = { space = " ", tab = "  ", trail = ".", nbsp = " " }

-- -----------------------------------------------------------------------------
-- > Plugin Setup
-- -----------------------------------------------------------------------------

vim.pack.add({
	-- { src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/tpope/vim-sleuth" },
	{ src = "https://github.com/nvim-mini/mini.nvim" },
	{ src = "https://github.com/christoomey/vim-tmux-navigator" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
})

-- Icon support
require("mini.icons").setup()
MiniIcons.tweak_lsp_kind()         -- Add 'kind icon' to completion menu
MiniIcons.mock_nvim_web_devicons() -- Mock web_devicons plugin

-- Highlight certain patterns
local mini_hipatterns = require("mini.hipatterns")
mini_hipatterns.setup({
	highlighters = {
		-- Highlight "FIXME", "HACK", "TODO", "NOTE"
		fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
		hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
		todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
		note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

		-- Highlight hex color strings (`#rrggbb`) using that color
		hex_color = mini_hipatterns.gen_highlighter.hex_color(),
	},
})
-- Completions
require("mini.completion").setup({
	lsp_completion = {
		source_func = "omnifunc",
		auto_setup = false, -- Setup via "LspAttach" autocommand
	},
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		vim.bo[args.buf].omnifunc = "v:lua.MiniCompletion.completefunc_lsp"
	end,
})

-- Picker
require("mini.pick").setup({ window = { config = { border = "rounded" } }, })
require("mini.extra").setup()

-- Custom picker: All files (hidden, ignored)
MiniPick.registry.all_files = function()
	local command = { "fd", "--type=f", "--no-follow", "--color=never", "--hidden" }
	local show_with_icons = function(buf_id, items, query)
		return MiniPick.default_show(buf_id, items, query, { show_icons = true })
	end
	local source = { name = "All Files (fd)", show = show_with_icons }
	return MiniPick.builtin.cli({ command = command }, { source = source })
end

-- Text editing (around/inside textobjects, autopairs, surround chars)
require("mini.ai").setup()
require("mini.pairs").setup()
require("mini.surround").setup()

-- Git (commands, branch/status info)
require("mini.git").setup()
require("mini.diff").setup({
	view = {
		style = "sign",
		signs = { add = "┃", change = "┃", delete = "⎼" },
	}
})

-- Multistep keymaps
local map_multistep = require("mini.keymap").map_multistep
map_multistep("i", "<Tab>", { "pmenu_next", "vimsnippet_next" })
map_multistep("i", "<S-Tab>", { "pmenu_prev", "vimsnippet_prev" })
map_multistep("i", "<CR>", { "pmenu_accept", "minipairs_cr" })
map_multistep("i", "<BS>", { "minipairs_bs" })

-- Tool installer/management (lsp, formatter, linter, etc.)
require("mason").setup()
local ls = {}
local mr = require("mason-registry")
for _, name in ipairs(mr.get_installed_package_names()) do
	local spec = mr.get_package(name).spec
	if spec and spec.neovim then
		table.insert(ls, spec.neovim.lspconfig)
	end
end

-- Lsp setup (auto-enable from mason)
vim.lsp.config("*", { capabilities = MiniCompletion.get_lsp_capabilities() })
vim.lsp.enable(ls)

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
		source = true, -- Include diagnostic source
		header = "", -- Hide window title
		prefix = "", -- Hide diagnostic number
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

		-- Enable folds
		-- vim.wo.foldmethod = "expr"
		-- vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"

		-- Start treesitter highlighting
		vim.treesitter.start(bufnr, lang)

		-- Use nvim-treesitter's indentexpr
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

-- -----------------------------------------------------------------------------
-- > Statusline
-- -----------------------------------------------------------------------------

-- Tweak mini.git/.diff branch and status string for statusbar
vim.api.nvim_create_autocmd("User", {
	pattern = "MiniGitUpdated",
	callback = function(data)
		local summary = vim.b.minigit_summary
		local head = summary.head_name or ""
		head = head == "HEAD" and summary.head:sub(1, 8) or head
		vim.b[data.buf].minigit_summary_string = head
	end
})

vim.api.nvim_create_autocmd("User", {
	pattern = "MiniDiffUpdated",
	callback = function(data)
		local summary = vim.b[data.buf].minidiff_summary
		local t = {}
		if summary.add > 0 then table.insert(t, " +" .. summary.add) end
		if summary.change > 0 then table.insert(t, " ~" .. summary.change) end
		if summary.delete > 0 then table.insert(t, " -" .. summary.delete) end
		vim.b[data.buf].minidiff_summary_string = table.concat(t)
	end
})

local function git()
	local branch, status = vim.b.minigit_summary_string, vim.b.minidiff_summary_string
	return branch and status and "[ " .. branch .. status .. "]" or ""
end

local function lsp()
	local s = vim.diagnostic.severity
	local signs = vim.diagnostic.config().signs.text or {}
	local icons = {
		[s.ERROR] = "%#DiagnosticSignError#" .. (signs[s.ERROR] or ""),
		[s.WARN]  = "%#DiagnosticSignWarn#" .. (signs[s.WARN] or ""),
		[s.INFO]  = "%#DiagnosticSignInfo#" .. (signs[s.INFO] or ""),
		[s.HINT]  = "%#DiagnosticSignHint#" .. (signs[s.HINT] or ""),
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

function User.statusline()
	return table.concat({ "%<%f %h%w%m%r", git(), "%=", lsp(), "%-14.(%l,%c%V%) %P" })
end

vim.opt.statusline = "%!v:lua.User.statusline()"

-- -----------------------------------------------------------------------------
-- > Autocommands
-- -----------------------------------------------------------------------------

-- Highlight text when yanking
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

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
map("n", "grf", vim.lsp.buf.format, { desc = "Format buffer" })
map("n", "grd", vim.lsp.buf.definition, { desc = "Definitions" })
map("n", "grD", vim.lsp.buf.declaration, { desc = "Declarations" })

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

-- -----------------------------------------------------------------------------
-- > Theme / Highlight Groups
-- -----------------------------------------------------------------------------
vim.api.nvim_set_hl(0, "Statusline", { bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "ColorColumn", { link = "Cursorline" })
vim.api.nvim_set_hl(0, "MiniPickBorder", { bg = "NONE", fg = "NvimDarkGrey4" })
vim.api.nvim_set_hl(0, "MiniPickNormal", { bg = "NONE" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { link = "Pmenu"})
-- vim.api.nvim_set_hl(0, "FloatBorder", { link = "Pmenu"})
-- vim.api.nvim_set_hl(0, "Pmenu", { link = "NormalFloat"})

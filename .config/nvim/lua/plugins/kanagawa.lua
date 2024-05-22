return {
	"rebelot/kanagawa.nvim",
	lazy = true,
	config = function()
		require("kanagawa").setup({
			overrides = function(colors)
				local theme = colors.theme
				return {
					-- Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },  -- add `blend = vim.o.pumblend` to enable transparency
					-- PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
					-- PmenuSbar = { bg = theme.ui.bg_m1 },
					-- PmenuThumb = { bg = theme.ui.bg_p2 },
					-- NormalFloat = { bg = "none" },
					-- FloatBorder = { bg = "none" },
					-- FloatTitle = { bg = "none" },
					--
					-- -- Save an hlgroup with dark background and dimmed foreground
					-- -- so that you can use it where your still want darker windows.
					-- -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
					-- NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
					--
					-- -- Popular plugins that open floats will link to NormalFloat by default;
					-- -- set their background accordingly if you wish to keep them dark and borderless
					-- LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
					-- MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
				}
			end,
		})
	end
}


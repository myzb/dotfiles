return {
	{
		"ray-x/lsp_signature.nvim",
		opts = {
			bind = true,
			hint_enable = false,
			doc_lines = 0,
			wrap = true,
			handler_opts = { border = "none" },
		},
		config = function(_, opts)
			require("lsp_signature").setup(opts)
		end,
	},
	{
		-- autocomplete braces, brackets, ...
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			check_ts = true,
		},
	},
	{
		"L3MON4D3/LuaSnip",
		lazy = true,
		build = "make install_jsregexp",
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			-- Completion sources
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-path",
			"windwp/nvim-autopairs",
			-- "hrsh7th/cmp-nvim-lsp-signature-help",

			-- Snipped support
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",

			-- Icons
			"onsails/lspkind.nvim",
		},
		event = { "InsertEnter", "CmdlineEnter" },
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")

			require("luasnip.loaders.from_vscode").lazy_load()
			cmp.setup({
				enabled = function()
					-- Disable completion in comments
					local context = require("cmp.config.context")
					-- Keep command mode completion enabled when cursor is in a comment
					if vim.api.nvim_get_mode().mode == "c" then
						return true
					else
						return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
					end
				end,
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol_text",
						menu = {
							buffer = "[Buffer]",
							nvim_lsp = "[LSP]",
							luasnip = "[LuaSnip]",
							nvim_lua = "[Lua]",
							latex_symbols = "[Latex]",
							lazydev = "[Lazydev]",
						},
					}),
					fields = { "abbr", "kind", "menu" },
					expandable_indicator = true,
				},
				window = {
					documentation = {
						-- Same highlights as the 'completion' menu
						winhighlight = "Normal:Pmenu,FloatBorder:Pmenu",
					},
				},
				mapping = cmp.mapping.preset.insert({
					["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item()),
					["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item()),
					["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4)),
					["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4)),
					["<C-Space>"] = cmp.mapping(cmp.mapping.complete()),
					["<C-e>"] = cmp.mapping(cmp.mapping.abort()),

					-- Safe-CR
					-- If nothing is selected (including preselections) add a newline as usual.
					-- If something has explicitly been selected by the user, select it.
					["<CR>"] = cmp.mapping({
						i = function(fallback)
							if cmp.visible() and cmp.get_active_entry() then
								cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
							else
								fallback()
							end
						end,
						s = cmp.mapping.confirm({ select = true }),
						c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
					}),
					-- Super-tab
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.locally_jumpable(1) then
							luasnip.jump(1)
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),

				sources = cmp.config.sources({
					-- { name = "nvim_lsp_signature_help" },
					{ name = "lazydev", group_index = 0 },
					{ name = "nvim_lsp", keyword_length = 2 },
					{ name = "luasnip", keyword_length = 2 },
				}, {
					{ name = "buffer", keyword_length = 3 },
				}),
				matching = {
					-- disallow_fuzzy_matching = true,
					-- disallow_partial_fuzzy_matching = true,
				},
				experimental = {
					ghost_text = false,
				},
			})
			-- Command line completions for '/' and '?'
			-- cmp.setup.cmdline({ "/", "?" }, {
			-- 	mapping = cmp.mapping.preset.cmdline(),
			-- 	sources = {
			-- 		{ name = "buffer" },
			-- 	},
			-- })
			--
			-- -- Command line completions for ':'
			-- cmp.setup.cmdline(":", {
			-- 	mapping = cmp.mapping.preset.cmdline(),
			-- 	sources = cmp.config.sources({
			-- 		{ name = "path" },
			-- 	}, {
			-- 		{ name = "cmdline" },
			-- 	}),
			-- 	matching = { disallow_symbol_nonprefix_matching = false },
			-- })

			-- autocompletion for '()' in function/methods
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},
}

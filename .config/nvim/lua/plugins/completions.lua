return {
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		opts = {
			hint_enable = false,
			doc_lines = 0,
			bind = false,
			handler_opts = { border = "none" },
		},
		config = function(_, opts)
			require("lsp_signature").setup(opts)
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			-- completion sources
			"hrsh7th/cmp-nvim-lsp",
			-- "hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-buffer",
			"windwp/nvim-autopairs",

			-- snipped support
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",

			-- icons
			"onsails/lspkind.nvim",
		},
		event = "InsertEnter",
		config = function()
			local cmp = require("cmp")
			local lsn = require("luasnip")
			local lspkind = require("lspkind")

			require("luasnip.loaders.from_vscode").lazy_load()

			local check_backspace = function()
				local col = vim.fn.col(".") - 1
				return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
			end
			cmp.setup({
				enabled = function()
					-- disable completion in comments
					local context = require("cmp.config.context")
					-- keep command mode completion enabled when cursor is in a comment
					if vim.api.nvim_get_mode().mode == "c" then
						return true
					else
						return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
					end
				end,
				snippet = {
					expand = function(args)
						lsn.lsp_expand(args.body)
					end,
				},
				completion = {
					completeopt = "menu,menuone",
				},
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol_text",
						menu = {
							nvim_lsp = "[LSP]",
							nvim_lua = "[Lua]",
							luasnip = "[LuaSnip]",
							buffer = "[Buffer]",
							latex_symbols = "[Latex]",
						},
					}),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
					["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
					["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
					["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
					["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
					["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
					--["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
					["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),

					-- Set `select` to `false` to only confirm explicitly selected items.
					--["<CR>"] = cmp.mapping.confirm({ select = false }),
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
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							--cmp.select_next_item()
							cmp.confirm({ select = true })
						elseif lsn.expandable() then
							lsn.expand()
						elseif lsn.expand_or_jumpable() then
							lsn.expand_or_jump()
						elseif check_backspace() then
							fallback()
							-- require("neotab").tabout()
						else
							fallback()
							-- require("neotab").tabout()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							--cmp.select_prev_item()
						elseif lsn.jumpable(-1) then
							lsn.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					-- { name = "nvim_lua" , keyword_length = 2},
					{ name = "nvim_lsp", keyword_length = 2},
					{ name = "luasnip" , keyword_length = 2},
				}, {
					{ name = "buffer" , keyword_length = 3 },
				}),
				matching = {
					disallow_fuzzy_matching = true,
					disallow_partial_fuzzy_matching = true,
				},
				experimental = {
					ghost_text = false,
				},
			})

			-- autocompletion for '()' in function/methods
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},
}

return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets" },
	event = { "InsertEnter", "CmdLineEnter" },
	version = "v0.10.0",
	opts = {
		keymap = {
			["<C-d>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "cancel", "fallback" },
			["<C-y>"] = { "select_and_accept", "fallback" },
			["<CR>"] = { "accept", "fallback" },

			["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
			["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
			["<C-n>"] = { "select_next", "fallback" },
			["<C-p>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
			["<Up>"] = { "select_prev", "fallback" },

			["<C-f>"] = { "scroll_documentation_down", "fallback" },
			["<C-b>"] = { "scroll_documentation_up", "fallback" },
		},
		completion = {
			-- Enable auto brackets
			accept = { auto_brackets = { enabled = true } },
			-- Insert completion item on selection, don't select by default
			list = {
				selection = { preselect = false, auto_insert = true },
			},
			-- Display a preview of the selected item on the current line
			ghost_text = { enabled = false },
		},
		appearance = {
			-- Use cmp hl-groups as fallback
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
		},
		-- Completion providerses
		sources = {
			default = { "lazydev", "lsp", "path", "snippets", "buffer" },
			providers = {
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					score_offset = 100,
				},
				snippets = {
					min_keyword_length = 1,
				},
				buffer = {
					min_keyword_length = 4,
				},
			},
		},
		signature = { enabled = true },
	},
	opts_extend = { "sources.default" },
}

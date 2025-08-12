return {
	-- Autoformat
	"stevearc/conform.nvim",
	dependencies = { "williamboman/mason.nvim" },
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<Leader>cF",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "n",
			desc = "Format buffer",
		},
	},
	opts = {
		notify_on_error = false,
		format_on_save = function(bufnr)
			-- Disable 'format_on_save' for some languages
			local disable = {
				c = true,
				cpp = true,
				cmake = true,
			}
			local ft = vim.bo[bufnr].filetype
			return {
				timeout_ms = 500,
				lsp_format = disable[ft] and "never" or "fallback",
			}
		end,
		formatters_by_ft = {
			lua = { "stylua" },
			-- python = { "isort", "black" },
		},
	},
}

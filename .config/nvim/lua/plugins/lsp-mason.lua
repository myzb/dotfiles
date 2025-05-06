return {
	{
		"mason-org/mason.nvim",
		opts = {},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
			{ "j-hui/fidget.nvim", opts = {} }, -- Progress spinner
		},
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			servers = {
				clangd = {
					cmd = { "clangd", "--fallback-style=webkit" },
				},
				lua_ls = {},
				pyright = {},
			},
			tools = {
				prettier = {},
				stylua = {},
				isort = {},
				black = {},
				pylint = {},
			},
		},
		config = function(_, opts)
			-- Auto-install non-lsp tools
			local mr = require("mason-registry")
			mr.refresh(function()
				for name, _ in pairs(opts.tools or {}) do
					local p = mr.get_package(name)
					if not p:is_installed() then
						p:install()
					end
				end
			end)

			-- Lsp base config
			vim.lsp.config("*", { capabilities = MiniCompletion.get_lsp_capabilities() })

			-- Lsp server specific configs
			for name, conf in pairs(opts.servers or {}) do
				vim.lsp.config(name, conf)
			end

			-- Auto-install/-enable lsp servers
			local ensure_installed = vim.tbl_keys(opts.servers or {})
			require("mason").setup()
			require("mason-lspconfig").setup({
				automatic_enable = true,
				ensure_installed = ensure_installed,
			})

			-- Lsp diagnostics display
			vim.diagnostic.config({
				virtual_text = false,
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = " ",
						[vim.diagnostic.severity.WARN] = " ",
						[vim.diagnostic.severity.INFO] = " ",
						[vim.diagnostic.severity.HINT] = " ",
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

			-- Keymaps
			vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Show diagnostics" })

			-- Buffer on-attach keymaps
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
				callback = function(args)
					-- Attach completion engine
					vim.bo[args.buf].omnifunc = "v:lua.MiniCompletion.completefunc_lsp"

					-- Keymap helper
					local function map(k, f, d)
						vim.keymap.set("n", k, f, { buffer = args.buf, desc = d })
					end

					map("<Leader>rn", vim.lsp.buf.rename, "Rename variable")
					map("<Leader>ca", vim.lsp.buf.code_action, "Code action")
					map("K", vim.lsp.buf.hover, "Hover documentation")
					map("gD", vim.lsp.buf.declaration, "Goto declaration")
					map("<Leader>ls", vim.lsp.buf.signature_help, "Show signature")
				end,
			})
		end,
	},
}

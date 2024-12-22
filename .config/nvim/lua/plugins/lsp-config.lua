return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Lsp plugin manager
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			-- Useful status updates for LSP.
			{ "j-hui/fidget.nvim", opts = {} },
		},
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			-- Setup lsp's handlers
			local lspconfig = require("lspconfig")
			local mason_lspconfig = require("mason-lspconfig")

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			-- local capabilities = require("blink.cmp").get_lsp_capabilities()

			mason_lspconfig.setup_handlers({
				-- Default handler
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = capabilities,
					})
				end,
				-- Special handlers
				["clangd"] = function()
					-- copilot expects utf-16 encoding
					local c = {
						offsetEncoding = { "utf-16" },
					}
					lspconfig["clangd"].setup({
						capabilities = vim.tbl_deep_extend("force", capabilities, c),
						cmd = { "clangd", "--fallback-style=webkit" },
					})
				end,
			})

			-- Lsp diagnostics as hint icons in sign-column
			local signs = {
				{ name = "DiagnosticSignError", text = "" },
				{ name = "DiagnosticSignWarn", text = "" },
				{ name = "DiagnosticSignHint", text = "" },
				{ name = "DiagnosticSignInfo", text = "" },
			}
			for _, sign in ipairs(signs) do
				vim.fn.sign_define(sign.name, {
					texthl = sign.name,
					text = sign.text,
					numhl = "",
				})
			end
			vim.diagnostic.config({
				virtual_text = false,
				signs = {
					active = signs,
				},
				update_in_insert = true,
				underline = true,
				seventerity_sort = true,
				float = {
					focusable = false,
					style = "minimal",
					border = "none",
					source = true,
					header = "",
					prefix = "",
				},
			})

			-- Borders around windows that normally don't have
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
				border = "none",
			})
			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
				border = "none",
			})

			-- Lsp keypmaps
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(event)
					-- Attach completion engine
					vim.bo[event.buf].omnifunc = "v:lua.MiniCompletion.completefunc_lsp"

					-- Keymaps
					local function map(k, f, d)
						vim.keymap.set("n", k, f, { buffer = event.buf, desc = d })
					end

					local fzf = require("fzf-lua")

					map("gd", fzf.lsp_definitions, "[G]oto [D]efinition")
					map("gr", fzf.lsp_references, "[G]oto [R]eferences")
					map("gI", fzf.lsp_implementations, "[G]oto [I]mplementation")
					map("<Leader>dd", fzf.lsp_document_diagnostics, "Document diagnostics")
					map("<Leader>D", fzf.lsp_typedefs, "Type [D]efinition")

					-- Symbol (variables, functions, ...) search in current document/workspace
					map("<Leader>ds", fzf.lsp_document_symbols, "[D]ocument [S]ymbols")
					map("<Leader>ws", fzf.lsp_live_workspace_symbols, "[W]orkspace [S]ymbols")

					map("<Leader>rn", vim.lsp.buf.rename, "[R]e[n]ame variable")
					map("<Leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
					map("K", vim.lsp.buf.hover, "Hover Documentation")
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

					map("<Leader>ls", vim.lsp.buf.signature_help, "Show Signature")
					map("gl", vim.diagnostic.open_float, "Show Diagnostics")
				end,
			})
		end,
	},
}

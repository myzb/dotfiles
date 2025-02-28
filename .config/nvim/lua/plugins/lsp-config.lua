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
			-- local capabilities = require("blink.cmp").get_lsp_capabilities()
			local capabilities = vim.lsp.protocol.make_client_capabilities()

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
				{ name = "DiagnosticSignHint", text = "" },
				{ name = "DiagnosticSignInfo", text = "" },
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

			-- General keymaps
			-- local fzf = require("fzf-lua")

			vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Show diagnostics" })
			-- vim.keymap.set("n", "<Leader>dd", fzf.diagnostics_document, { desc = "Document diagnostics" })

			-- Buffer on-attach keymaps
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(event)
					-- Attach completion engine
					vim.bo[event.buf].omnifunc = "v:lua.MiniCompletion.completefunc_lsp"

					-- Keymap helper
					local function map(k, f, d)
						vim.keymap.set("n", k, f, { buffer = event.buf, desc = d })
					end

					-- map("gd", fzf.lsp_definitions, "Goto definition")
					-- map("gr", fzf.lsp_references, "Goto references")
					-- map("gI", fzf.lsp_implementations, "Goto implementation")
					-- map("<Leader>D", fzf.lsp_typedefs, "Type definition")

					-- Symbol (variables, functions, ...) search in current document/workspace
					-- map("<Leader>ds", fzf.lsp_document_symbols, "Document symbols")
					-- map("<Leader>ws", fzf.lsp_live_workspace_symbols, "Workspace symbols")

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

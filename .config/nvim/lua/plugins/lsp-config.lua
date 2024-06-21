return {
	"neovim/nvim-lspconfig",
	dependencies = {
		-- lsp manager
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		-- Useful status updates for LSP.
	--	{ 'j-hui/fidget.nvim', opts = {} },

		-- Extra configs for LSP anotations, signature. ...
		{ "folke/neodev.nvim", opts = {} },

		-- client lsp capabilities from cmp
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		-- lsp diagnostics as hint icons in sign-column
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

		local config = {
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
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		}
		vim.diagnostic.config(config)

		-- add borders to windows that normally don't have
		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
			border = "rounded",
		})
		vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
			border = "rounded",
		})

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		-- define setup func
		local default_setup = function(server_name)
			local conf = {
				capabilities = capabilities,
			}

			if server_name == "clangd" then
				conf.cmd = { "clangd", "--fallback-style=webkit" }
			end

			require("lspconfig")[server_name].setup(conf)
		end

		-- manually setup lsp's not handled by mason
		local lsp_provider = { "pyright" }

		for _, name in pairs(lsp_provider) do
			default_setup(name)
		end

		-- automatically setup lsp's that can be handled by mason
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = { "clangd", "lua_ls" },
			handlers = {
				default_setup,
			},
		})

		-- Use LspAttach autocommand to only map the following keys
		-- after the language server attaches to the current buffer
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(event)
				local function map(k, f, d)
					vim.keymap.set("n", k, f, { buffer = event.buf, desc = d })
				end

				-- Enable completion triggered by <><c-o>
				-- Jump to the definition of the word under your cursor.
				--  This is where a variable was first declared, or where a function is defined, etc.
				--  To jump back, press <C-t>.
				map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

				-- Find references for the word under your cursor.
				map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

				-- Jump to the implementation of the word under your cursor.
				--  Useful when your language has ways of declaring types without an actual implementation.
				map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

				-- Jump to the type of the word under your cursor.
				--  Useful when you're not sure what type a variable is and you want to see
				--  the definition of its *type*, not where it was *defined*.
				map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

				-- Fuzzy find all the symbols in your current document.
				--  Symbols are things like variables, functions, types, etc.
				map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

				-- Fuzzy find all the symbols in your current workspace.
				--  Similar to document symbols, except searches over your entire project.
				map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

				-- Rename the variable under your cursor.
				--  Most Language Servers support renaming across files, etc.
				map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

				-- Execute a code action, usually your cursor needs to be on top of an error
				-- or a suggestion from your LSP for this to activate.
				map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

				-- Opens a popup that displays documentation about the word under your cursor
				--  See `:help K` for why this keymap.
				map('K', vim.lsp.buf.hover, 'Hover Documentation')

				-- WARN: This is not Goto Definition, this is Goto Declaration.
				--  For example, in C this would take you to the header.
				map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

				map("<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Show Signature")
				map("<leader>lf", "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", "Autoformat BUffer")
				map("gl", "<cmd>lua vim.diagnostic.open_float()<cr>", "Show Diagnostics")

				-- -- The following two autocommands are used to highlight references of the
				-- -- word under your cursor when your cursor rests there for a little while.
				-- --    See `:help CursorHold` for information about when this is executed
				-- -- When you move your cursor, the highlights will be cleared (the second autocommand).
				-- local client = vim.lsp.get_client_by_id(event.data.client_id)
				-- if client and client.server_capabilities.documentHighlightProvider then
				-- 	vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				-- 		buffer = event.buf,
				-- 		callback = vim.lsp.buf.document_highlight,
				-- 	})
				--
				-- 	vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				-- 		buffer = event.buf,
				-- 		callback = vim.lsp.buf.clear_references,
				-- 	})
				-- end
			end,
		})
	end,
}

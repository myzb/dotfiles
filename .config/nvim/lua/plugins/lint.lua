return {
	-- Linting
	"mfussenegger/nvim-lint",
	dependencies = { "williamboman/mason.nvim" },
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		-- Explicitly set linters and override internal defaults
		lint.linters_by_ft = {
			text = { "vale" },
			json = { "jsonlint" },
			markdown = { "vale" },
			rst = { "vale" },
			dockerfile = { "hadolint" },
			yaml = { "yamllint" },
			latex = { "vale" },
		}

		-- Autocommand to handle the linting
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = vim.api.nvim_create_augroup("lint", { clear = true }),
			callback = function()
				-- Only run the linter in buffers that can be modified
				if vim.opt_local.modifiable:get() then
					lint.try_lint()
				end
			end,
		})
	end,
}

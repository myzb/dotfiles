return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	keys = {
		{ "<Leader>e", "<Cmd>Neotree toggle<CR>", desc = "File explorer" },
	},
	opts = {
		filesystem = {
			filtered_items = {
				visible = false,
			},
		},
		default_component_configs = {
			symlink_target = {
				enabled = false,
			},
		},
	},
	config = function(_, opts)
		local function shorten_path(path, sep)
			local segments = vim.split(path, sep)

			-- Drop last segment if emtpy string
			if segments[#segments] == "" then
				segments[#segments] = nil
			end

			-- Do not shorten last segment
			for idx = 1, #segments - 1 do
				local segment = segments[idx]
				segments[idx] = segment:sub(1, vim.startswith(segment, ".") and 2 or 1)
			end

			return table.concat(segments, sep)
		end

		-- Shorten title, e.g.: ~/foo/bar/baz -> ~/f/b/baz
		local fc = require("neo-tree.sources.filesystem.components")
		local filesystem = {
			components = {
				name = function(config, node, state)
					local result = fc.name(config, node, state)
					if node:get_depth() == 1 and node.type ~= "message" then
						local sep = package.config:sub(1, 1)
						local path = vim.fn.fnamemodify(node.path, ":p:~")
						result.text = shorten_path(path, sep)
					end
					return result
				end,
			},
		}
		opts.filesystem = vim.tbl_deep_extend("force", {}, filesystem, opts.filesystem or {})

		require("neo-tree").setup(opts)
	end,
}

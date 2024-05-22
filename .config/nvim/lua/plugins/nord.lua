return {
	"gbprod/nord.nvim",
	lazy = true,
	opts = {},
	config = function(_, opts)
		require("nord").setup(opts)
	end,
}

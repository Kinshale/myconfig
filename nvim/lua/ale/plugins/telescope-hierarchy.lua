return {
	"jmacadie/telescope-hierarchy.nvim",
	dependencies = {
		{ "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
	},
	opts = {
		extensions = {
			hierarchy = {}, -- defaults are fine to start
		},
	},
	config = function(_, opts)
		require("telescope").setup(opts)
		require("telescope").load_extension("hierarchy")
	end,
}

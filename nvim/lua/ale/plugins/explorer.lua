return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- Disable netrw, as recommended by nvim-tree docs (avoids conflicts).
	init = function()
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1
	end,
	config = function()
		require("nvim-tree").setup({
			view = {
				width = 32,
				side = "left",
			},
			renderer = {
				group_empty = true,
				icons = {
					git_placement = "before",
				},
			},
			-- Keep the tree's cwd in sync with vim's cwd (so your <leader>cd
			-- from earlier also reflects in the tree, if you use window/tab-local cd).
			update_focused_file = {
				enable = true,
				update_root = true,
			},
			filters = {
				dotfiles = false,
				git_ignored = false, -- set true if you don't want to see .gitignored files
			},
			git = {
				enable = true,
			},
		})

		local api = require("nvim-tree.api")

		vim.keymap.set("n", "<leader>e", api.tree.toggle, { desc = "[E]xplorer toggle" })
	end,
}

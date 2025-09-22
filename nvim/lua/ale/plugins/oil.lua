-- NOTE: Press g? to see default command once inside oil
-- C-p -> (Most useful command) Toggles the preview mode on the right.
-- <ESC> or <C-c> -> For quitting oil.

return {
	{
		"stevearc/oil.nvim",
		opts = {},
		dependencies = { "nvim-tree/nvim-web-devicons" },

		config = function()
			require("oil").setup({
				columns = {
					"icon",
					-- "permissions",
					"size",
					-- "mtime",
				},
				skip_confirm_for_simple_edits = true,
				delete_to_trash = true,
				view_options = { show_hidden = true },
				float = {
					max_width = 0.8,
					max_height = 0.8,
				},
				keymaps = {
					["<ESC>"] = { "actions.close", mode = "n" },
				},
			})
			-- vim.keymap.set("n", "<leader>-", require("oil").open, { desc = "Oil directory" })
			vim.keymap.set("n", "<leader>-", function()
				require("oil").open(vim.fn.expand("%:p:h"))
			end, { desc = "Oil directory" })
			vim.keymap.set("n", "-", require("oil").toggle_float, { desc = "Oil float" })
		end,
	},

	-- {
	-- 	"nvim-tree/nvim-tree.lua",
	-- 	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- 	config = function()
	-- 		vim.g.loaded_netrw = 1
	-- 		vim.g.loaded_netrwPlugin = 1
	-- 		require("nvim-tree").setup()
	-- 		vim.keymap.set("n", "_", "<CMD>NvimTreeToggle<CR>", { desc = "NvimTree directory" })
	-- 	end,
	-- },
}

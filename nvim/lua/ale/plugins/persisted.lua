-- LINK: The sessions are stored at ~/.local/share/nvim/sessions/

return {
	"olimorris/persisted.nvim",
	lazy = false, -- load on startup
	config = function()
		require("persisted").setup({
			autosave = true, -- automatically save session on exit
			autoload = true, -- automatically load session on start
			-- follow_cwd = true, -- automatically change cwd when loading sessions
			should_save = function()
				-- Only save if at least one file buffer is open
				local buffers = vim.tbl_filter(function(buf)
					return vim.api.nvim_buf_get_option(buf, "buftype") == ""
				end, vim.api.nvim_list_bufs())
				return #buffers > 0
			end,
			use_git_branch = true, -- sessions per git branch
			telescope = { -- enable Telescope integration
				enable = true,
			},
		})

		vim.keymap.set("n", "<leader>wpd", "<cmd>SessionDelete<CR>", { desc = "[P]ersisted [D]elete session" })

		-- DOUBT: Kind of useless if autosave and autoload are enabled
		vim.keymap.set("n", "<leader>wpl", "<cmd>SessionLoad<CR>", { desc = "[P]ersisted [L]oad session" })
		vim.keymap.set("n", "<leader>wps", "<cmd>SessionSave<CR>", { desc = "[P]ersisted [S]ave session" })

		vim.keymap.set("n", "<leader>ss", "<cmd>Telescope persisted<CR>", { desc = "[S]earch [S]essions" })

		-- Commands while in Telescope persisted (Be careful to be in insert mode)
		-- <CR> - Open/source the session file
		-- <C-b> - Add/update the git branch for the session file
		-- <C-c> - Copy the session file
		-- <C-d> - Delete the session file
	end,
}

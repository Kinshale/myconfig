-- HACK: To see shortcuts while in Telescope
--  - Insert mode: <c-/>
--  - Normal mode: ?

return {
	"nvim-telescope/telescope.nvim",

	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",

			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },

		-- Useful for getting pretty icons, but requires a Nerd Font.
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
	config = function()
		require("telescope").setup({
			defaults = {
				layout_strategy = "horizontal",
				layout_config = { width = 0.95, height = 0.90 },
			},
			extensions = { fzf = {} },
			pickers = {
				find_files = {
					-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
					find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
				},
			},
		})

		-- Enable Telescope extensions if they are installed
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")

		-- See `:help telescope.builtin`
		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<leader>so", builtin.buffers, { desc = "[S]earch [O]pen files" })
		vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
		vim.keymap.set("n", "<leader>sp", builtin.oldfiles, { desc = "[S]earch [P]revious files" }) -- Recently opened

		vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
		vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
		vim.keymap.set("n", "<leader>sj", builtin.jumplist, { desc = "[S]earch [J]ump list" })
		-- vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })

		vim.keymap.set("n", "<leader>sg", function()
			builtin.live_grep()
		end, { desc = "[S]earch [G]rep (all files)" })

		vim.keymap.set("n", "<leader>/", function()
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, { desc = "[/] Fuzzy (current buffer)" })

		-- vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch [W]ord" })
		-- vim.keymap.set("n", "<leader>s/", function()
		-- 	builtin.live_grep({
		-- 		grep_open_files = true,
		-- 		prompt_title = "Live Grep in Open Files",
		-- 	})
		-- end, { desc = "[S]earch [/] in Open Files" })
		--
		-- vim.keymap.set("n", "<leader>sn", function()
		-- 	builtin.find_files({ cwd = vim.fn.stdpath("config") })
		-- end, { desc = "[S]earch [N]eovim files" })
	end,
}

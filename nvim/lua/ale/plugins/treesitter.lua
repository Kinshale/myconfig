-- NOTE: Treesitter is a parsing system.
--
-- TODO: Add [ and ] commands

return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"c",
					"cpp",
					"python",
					"bash",
					"lua",
					"vim",
					"vimdoc",
					-- "rust",
					"markdown",
					"markdown_inline",
				},
				ignore_install = { "tex", "latex" },
				sync_install = true,
				auto_install = true,
				highlight = {
					enable = true,
					-- disable = { "tex", "latex" },
					disable = function(lang, buf)
						if lang == "tex" or lang == "latex" then
							return true
						end
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
						return false
					end,
				},
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["aa"] = "@parameter.outer",
							["ia"] = "@parameter.inner",
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
						},
					},

					move = {
						enable = true,
						set_jumps = true,

						goto_next_start = {
							["]f"] = "@function.outer",
							["]c"] = "@class.outer",
							["]a"] = "@parameter.outer",
						},
						goto_previous_start = {
							["[f"] = "@function.outer",
							["[c"] = "@class.outer",
							["[a"] = "@parameter.outer",
						},
						goto_next_end = {
							["]F"] = "@function.outer",
							["]C"] = "@class.outer",
							["]A"] = "@parameter.outer",
						},
						goto_previous_end = {
							["[F"] = "@function.outer",
							["[C"] = "@class.outer",
							["[A"] = "@parameter.outer",
						},
					},
				},
			})
		end,
	},
}

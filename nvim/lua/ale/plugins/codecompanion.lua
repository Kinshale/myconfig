-- Plugin specification for CodeCompanion with Copilot as backend
return {
	{
		"olimorris/codecompanion.nvim",
		version = "v17.33.0", -- NOTE: Pinning because of warning
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"zbirenbaum/copilot.lua",
		},
		lazy = true,
		event = { "VeryLazy" },

		-- Keep the configuration minimal and use Copilot as the adapter
		opts = {
			strategies = {
				chat = { adapter = "copilot" },
				inline = { adapter = "copilot" },
			},
			display = {
				action_palette = {
					width = 60,
					height = 10,
					prompt = "Prompt",
					provider = "default", -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks". If not specified, the plugin will autodetect installed providers.
					opts = {
						show_preset_actions = true, -- Show the preset actions in the action palette?
						show_preset_prompts = true, -- Show the preset prompts in the action palette?
						title = "CodeCompanion actions", -- The title of the action palette
					},
				},
			},
		},

		config = function(_, opts)
			if pcall(require, "copilot") then
				require("copilot").setup({})
			end

			require("codecompanion").setup(opts)

			-- Keymaps using <leader>c (ChatGPT/Copilot)
			local map = vim.keymap.set
			local kopts = { noremap = true, silent = true }

			map(
				{ "n", "v" },
				"<leader>ca",
				"<cmd>CodeCompanionActions<cr>",
				vim.tbl_extend("force", kopts, { desc = "[C]opilot [A]ctions" })
			)

			map(
				{ "n", "v" },
				"<leader>cc",
				"<cmd>CodeCompanionChat Toggle<cr>",
				vim.tbl_extend("force", kopts, { desc = "[C]opilot [C]hat" })
			)

			map(
				{ "n", "v" },
				"<leader>ci",
				"<cmd>CodeCompanion<cr>",
				vim.tbl_extend("force", kopts, { desc = "[C]opilot [I]nline Prompt" })
			)

			map(
				"v",
				"<leader>cs",
				"<cmd>CodeCompanionChat Add<cr>",
				vim.tbl_extend("force", kopts, { desc = "[C]opilot add code" })
			)
		end,
	},
}

-- NOTE: This file cannot be called copilot.lua, since it cause errors when opening the copilot buffer chat.

return {
	{
		"zbirenbaum/copilot.lua",
		config = function()
			require("copilot").setup({})
		end,
	},
}

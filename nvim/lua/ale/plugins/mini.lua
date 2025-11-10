-- A collection of various small independent plugins/modules

return {
	"echasnovski/mini.nvim",
	config = function()
		-- Better Around/Inside textobjects:
		--  - va)  - [V]isually select [A]round [)]paren
		--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
		require("mini.ai").setup({ n_lines = 500 })

		-- Add/delete/replace surroundings (brackets, quotes, etc.)
		-- Note: you need to be fast ...
		-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
		-- - sd'   - [S]urround [D]elete [']quotes
		-- - sr)'  - [S]urround [R]eplace [)] []
		require("mini.surround").setup({
			-- LINK: In after/ftplugin/tex.lua there are some custom surroundings.
			custom_surrondings = {},
		})

		-- It lets you align text interactively comments, asssignmnts, tables, CSV like data ...
		--  - ga → align with a prompt (you type the delimiter or regex).
		--  - gA → same, but align with preview and more advanced options.
		require("mini.align").setup()

		-- Lets you move lines and selected text via Alt + hjkl.
		require("mini.move").setup()

		-- Simple and easy statusline.
		--  You could remove this setup call if you dont like it,
		--  and try some other statusline plugin
		local statusline = require("mini.statusline")
		-- set use_icons to true if you have a Nerd Font
		statusline.setup({ use_icons = vim.g.have_nerd_font })

		-- You can configure sections in the statusline by overriding their
		-- default behavior. For example, here we set the section for
		-- cursor location to LINE:COLUMN
		---@diagnostic disable-next-line: duplicate-set-field
		statusline.section_location = function()
			return "%2l:%-2v"
		end

		-- ... and there is more!
		--  Check out: https://github.com/echasnovski/mini.nvim
	end,
}

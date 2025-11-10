return {
	"lervag/vimtex",
	lazy = false, -- NOTE: VimTeX is already lazy loaded by virtue
	config = function()
		vim.g.vimtex_view_method = "zathura"
		vim.g.vimtex_compiler_method = "latexmk"
		vim.g.vimtex_quickfix_mode = 0
		vim.g.vimtex_mappings_enabled = 0 -- NOTE: Remapped the keybindings in after/ftplugin/tex.lua

		vim.g.vimtex_compiler_latexmk = {
			aux_dir = "",
			out_dir = "",
			callback = 1,
			continuous = 0,
			executable = "latexmk",
			hooks = {},
			options = {
				"-verbose",
				"-file-line-error",
				"-synctex=1",
				"-interaction=nonstopmode",
				"-shell-escape",
			},
		}
	end,
}

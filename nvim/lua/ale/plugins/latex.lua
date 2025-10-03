return {
	"lervag/vimtex",
	config = function()
		vim.g.vimtex_view_method = "zathura"
		vim.g.vimtex_compiler_method = "latexmk"
		vim.g.vimtex_quickfix_mode = 0
		vim.g.vimtex_mappings_enable = 0

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

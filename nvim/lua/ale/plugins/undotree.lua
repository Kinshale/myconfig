-- NOTE: Unlike most editors that have a simple linear undo history (where you can only go back step-by-step), Neovim maintains a branching tree structure of your changes. Every time you make changes after undoing some edits, you create a new branch in the undo history.
return {
	"mbbill/undotree",
	config = function()
		vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "[U]ndo tree" })
	end,
}

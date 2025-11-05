-- Detect when running inside VSCode
if not vim.g.vscode then
	return
end

vim.o.clipboard = "unnamedplus"

vim.api.nvim_create_autocmd("textyankpost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 150,
		})
	end,
})

-- Set the map leader
vim.g.mapleader = " "

-- Keymaps (these call VS Code commands)
local opts = { noremap = true, silent = true }
local vscode = require("vscode")

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Map <C-y> to accept current suggestion in VSCode
-- FIX: Doesn't work
-- vim.keymap.set("i", "<C-y>", function()
-- 	vscode.action("acceptSelectedSuggestion")
-- end, opts)

-- s by default deletes a character and enters insert mode
vim.keymap.set("n", "s", "<Nop>")
vim.keymap.set("x", "s", "<Nop>")

-- Swallow problematic Ctrl + hjkl combos in normal mode
vim.keymap.set("n", "<C-h>", "<Nop>", opts)
vim.keymap.set("n", "<C-j>", "<Nop>", opts)
vim.keymap.set("n", "<C-k>", "<Nop>", opts)
vim.keymap.set("n", "<C-l>", "<Nop>", opts)

-- HACK: 🧩 Enabling / navigating major panels
local panels_mappings = {
	e = "workbench.view.explorer",
	o = "outline.focus",
	g = "workbench.view.scm",
	d = "workbench.view.debug",
	x = "workbench.view.extensions",
	z = "workbench.action.toggleZenMode",
}

for key, command in pairs(panels_mappings) do
	vim.keymap.set({ "n", "v" }, "<leader>" .. key, function()
		vscode.call(command)
	end, opts)
end

-- HACK: 🔍 Searching stuff
vim.keymap.set("n", "<leader>sf", function() -- Search files (Quick Open)
	vscode.call("workbench.action.quickOpen")
end, opts)

vim.keymap.set("n", "<leader>sg", function() -- Search by grep (global search)
	vscode.call("workbench.action.findInFiles")
end, opts)

vim.keymap.set("n", "<leader>ss", function() -- Search symbols (Go to Symbol in File)
	vscode.call("workbench.action.gotoSymbol")
end, opts)

vim.keymap.set("n", "<leader>sw", function() -- Search workspace symbols
	vscode.call("workbench.action.showAllSymbols")
end, opts)

-- HACK: 🛠️ Others
vim.keymap.set("n", "<leader>f", function() -- Format document
	vscode.call("editor.action.formatDocument")
end, opts)

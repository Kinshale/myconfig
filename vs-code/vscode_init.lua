-- Detect when running inside VSCode
if not vim.g.vscode then
	return
end

-- Set the map leader
vim.g.mapleader = " "

-- Keymaps (these call VS Code commands)
local opts = { noremap = true, silent = true }
local vscode = require("vscode")

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- CHAPTER: Copy and Pasting
vim.o.clipboard = ""
vim.g.clipboard = vim.g.vscode_clipboard

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "[Y]ank to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "[D]elete without yank" })

vim.keymap.set({ "n", "v" }, "<C-v>", '"+p', { desc = "Paste system clipboard" })
vim.keymap.set("i", "<C-v>", '<Esc>"+pa', { desc = "Paste system clipboard (insert)" })

vim.api.nvim_create_autocmd("textyankpost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 150,
		})
	end,
})

-- Map <C-y> to accept current suggestion in VSCode
-- FIX: Doesn't work (Move to shortcuts.json)
-- vim.keymap.set("i", "<C-y>", function()
-- 	vscode.action("acceptSelectedSuggestion")
-- end, opts)

-- s by default deletes a character and enters insert mode
vim.keymap.set("n", "s", "<Nop>")
vim.keymap.set("x", "s", "<Nop>")

-- Swallow problematic Ctrl + hjkl combos in normal mode
-- vim.keymap.set("n", "<C-h>", "<Nop>", opts)
-- vim.keymap.se t("n", "<C-j>", "<Nop>", opts)
-- vim.keymap.set("n", "<C-k>", "<Nop>", opts)
-- vim.keymap.set("n", "<C-l>", "<Nop>", opts)
--
-- TODO: Folding
--
-- TODO: Surround?
